import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesession/models/tunes/youtubeSearch.dart';
import 'package:thesession/models/tunes/youtubeVideo.dart';
import 'package:thesession/widgets/explore/setting_display_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../main.dart';
import '../../models/tunes/tuneInfo.dart';
import '../../utils/constants.dart';
import '../../widgets/community/comment_card.dart';

class PostPage extends StatefulWidget {
  final Post post;
  final Container webView;
  const PostPage({super.key, required this.post, required this.webView});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String videoUrl = '';

  Future<bool> getYoutubeVideo() async {
    Uri uri = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?key=${Constants.YT_API_KEY}&q=${widget.post.tuneInfo?.name ?? 'Cooley\'s Reel'} Traditional Irish Music&type=video&part=snippet&videoType=any');
    final searchResponse = await http.get(uri);
    if (searchResponse.statusCode == 200) {
      final YoutubeSearch result = youtubeSearchFromJson(searchResponse.body);
      uri = Uri.parse(
          'https://www.googleapis.com/youtube/v3/videos?key=${Constants.YT_API_KEY}&id=${result.items[0].id.videoId}&part=player');
      final videoReponse = await http.get(uri);
      if (videoReponse.statusCode == 200) {
        final YoutubeVideo resultVideo =
            youtubeVideoFromJson(videoReponse.body);
        videoUrl = extractVideoUrl(resultVideo.items[0].player.embedHtml) ?? '';
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.post.tuneInfo!.name),
        backgroundColor: AppColours.DefaultDarkColour,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TuneCard(
                post: widget.post,
                showFooter: true,
                ignorePadding: true,
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  child: const Text(
                    "Comments",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => openYoutubeVideo(),
                    child: Row(
                      children: [
                        Text(
                          'Youtube',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        FutureBuilder(
                          future: getYoutubeVideo(),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData)
                              return Icon(
                                Icons.open_in_new,
                                color: Colors.blue,
                              );
                            else
                              return SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ));
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CommentCard(
                      member: widget.post.tuneInfo!.comments[index].member,
                      comment: widget.post.tuneInfo!.comments[index]);
                },
                itemCount: widget.post.tuneInfo!.comments.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  openYoutubeVideo() {
    if (videoUrl.isNotEmpty) {
      launchUrl(Uri.parse('https:' + videoUrl));
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  String? extractVideoUrl(String html) {
    RegExp regex = RegExp(r'src=\"(.+?)\"');
    RegExpMatch? match = regex.firstMatch(html);
    if (match != null) {
      return match.group(1);
    } else {
      return null;
    }
  }
}
