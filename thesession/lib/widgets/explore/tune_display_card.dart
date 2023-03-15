import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesession/models/tunes/tuneInfo.dart';
import 'package:thesession/widgets/profile_icon.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TuneCard extends StatefulWidget {
  final Post post;
  const TuneCard({Key? key, required this.post}) : super(key: key);

  @override
  State<TuneCard> createState() => _TuneCardState();
}

class _TuneCardState extends State<TuneCard> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
                    child: ProfileIcon(
                        username: widget.post.member.name.toString()),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 20, 0, 0),
                    child: Text(
                      widget.post.member.name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
        Text(
            widget.post.tuneInfo != null ? widget.post.tuneInfo!.name : 'Test'),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
        //   child: Text(widget.post.abc),
        // ),
        Container(
          width: 380,
          height: 200,
          child: WebView(
            initialUrl: '',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              _loadHtmlFromAssets();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Text("See comments"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 3),
              child: Wrap(
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
              ),
            )
          ],
        ),
      ],
    );
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString('assets/abc.html');
    _controller.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
