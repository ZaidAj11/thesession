import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesession/models/tunes/tuneInfo.dart';
import 'package:thesession/widgets/profile_icon.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../pages/Tunes/post_page.dart';

class TuneCard extends StatefulWidget {
  final Post post;
  final bool? showFooter;
  const TuneCard({Key? key, required this.post, this.showFooter})
      : super(key: key);

  @override
  State<TuneCard> createState() => _TuneCardState();

  static Container getSheetMusic(Post post) {
    late WebViewController _controller;
    return Container(
      width: 380,
      height: 130,
      child: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtmlFromAssets(post.tuneInfo!.name, post.key,
              post.tuneInfo!.type, post.abc, _controller);
        },
      ),
    );
  }

  static _loadHtmlFromAssets(String name, String key, String type, String abc,
      WebViewController controller) async {
    String fileHtmlContents = await rootBundle.loadString('assets/abc.html');
    fileHtmlContents = fileHtmlContents.replaceAll("<NAME>", name);
    fileHtmlContents = fileHtmlContents.replaceAll("<KEY>", key);
    fileHtmlContents = fileHtmlContents.replaceAll("<TYPE>", type);
    fileHtmlContents = fileHtmlContents.replaceAll("<ABC>", abc);
    controller.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

class _TuneCardState extends State<TuneCard> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  late WebViewController _controller;
  late Container webView;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToPost(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                      child: ProfileIcon(
                          username: widget.post.member.name.toString()),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 20, 0, 0),
                      child: Text(
                        widget.post.member.name,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                child: Text(
                  formatter.format(widget.post.date).toString(),
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          //Text(
          //    widget.post.tuneInfo != null ? widget.post.tuneInfo!.name : 'Test'),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
          //   child: Text(widget.post.abc),
          // ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: webView = TuneCard.getSheetMusic(widget.post)),
          if (widget.showFooter != null && widget.showFooter!)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("See comments"),
                  Wrap(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 28,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.bookmark_add_outlined,
                        size: 28,
                      )
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _navigateToPost(BuildContext context) {
    Post item = widget.post;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostPage(
          webView: TuneCard.getSheetMusic(item),
          post: item,
        ),
      ),
    );
  }
}
