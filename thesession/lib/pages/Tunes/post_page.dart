import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thesession/widgets/explore/tune_display_card.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../main.dart';
import '../../models/tunes/tuneInfo.dart';
import '../../widgets/community/comment_card.dart';

class PostPage extends StatelessWidget {
  final Post post;
  final Container webView;
  const PostPage({super.key, required this.post, required this.webView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(post.tuneInfo!.name),
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
                post: post,
              ),
            ),
            Divider(
              thickness: 2,
            ),
            const Text(
              "Comments",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Divider(
              thickness: 0.5,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CommentCard(
                      member: post.tuneInfo!.comments[index].member,
                      comment: post.tuneInfo!.comments[index]);
                },
                itemCount: post.tuneInfo!.comments.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
