import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesession/models/tunes/tuneInfo.dart';
import 'package:thesession/utils/firestoreService.dart';
import 'package:thesession/widgets/profile_icon.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../pages/Tunes/post_page.dart';

class TuneCard extends StatefulWidget {
  final Post post;
  final bool? showFooter;
  bool? ignorePadding;
  bool? isLiked;
  TuneCard(
      {Key? key,
      required this.post,
      this.showFooter,
      this.isLiked,
      this.ignorePadding})
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
    fileHtmlContents = fileHtmlContents.replaceAll("!", "\n");
    controller.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

class _TuneCardState extends State<TuneCard> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  late WebViewController _controller;
  late Container webView;
  bool isLiked = false;
  bool isBookmarked = false;

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
                      padding: widget.ignorePadding != null
                          ? EdgeInsets.all(0)
                          : const EdgeInsets.fromLTRB(8, 8, 0, 0),
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
                padding: widget.ignorePadding != null
                    ? EdgeInsets.all(0)
                    : EdgeInsets.fromLTRB(0, 8, 8, 0),
                child: Text(
                  formatter.format(widget.post.date).toString(),
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          Padding(
              padding: widget.ignorePadding != null
                  ? EdgeInsets.fromLTRB(0, 8, 0, 8)
                  : const EdgeInsets.all(8.0),
              child: webView = TuneCard.getSheetMusic(widget.post)),
          if (widget.showFooter != null && widget.showFooter!)
            Padding(
              padding: widget.ignorePadding != null
                  ? EdgeInsets.all(0)
                  : const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: widget.ignorePadding != null
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.ignorePadding == null)
                    Text(
                      "See comments",
                      style: TextStyle(color: Colors.blue),
                    ),
                  Wrap(
                    children: [
                      GestureDetector(
                        onTap: () => likePost(),
                        child: FutureBuilder(
                          future: FireStoreService.getLikedTunes(),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData)
                              return getLikeIcon();
                            else
                              return SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator());
                          }),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () => bookmarkPost(),
                        child: FutureBuilder(
                          future: FireStoreService.getBookmarkedTunes(),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData)
                              return getBookmarkIcon();
                            else
                              return SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator());
                          }),
                        ),
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

  Icon getLikeIcon() {
    isLiked =
        FireStoreService.checkIfLiked(widget.post.tuneInfo!.id, widget.post.id);

    if (isLiked)
      return Icon(
        Icons.favorite,
        size: 28,
        color: Colors.red,
      );
    else
      return Icon(
        Icons.favorite_border,
        size: 28,
      );
  }

  Icon getBookmarkIcon() {
    isLiked = FireStoreService.checkIfBookmarkedTune(
        widget.post.tuneInfo!.id, widget.post.id);

    if (isLiked)
      return Icon(
        Icons.bookmark,
        size: 28,
        color: Colors.orange,
      );
    else
      return Icon(
        Icons.bookmark_add_outlined,
        size: 28,
      );
  }

  void likePost() async {
    await FireStoreService.likePost(widget.post.tuneInfo!.id, widget.post.id);
    setState(() {
      isLiked = !isLiked;
    });
  }

  void bookmarkPost() async {
    await FireStoreService.bookmarkPost(
        widget.post.tuneInfo!.id, widget.post.id);
    setState(() {
      isBookmarked = !isBookmarked;
    });
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
