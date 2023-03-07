import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/community/sessionInfo.dart';
import '../profile_icon.dart';

class CommentCard extends StatelessWidget {
  DateFormat get formatter => DateFormat('dd-MM-yyyy');
  final Member member;
  final Comment comment;
  const CommentCard({super.key, required this.member, required this.comment});

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
                    child: ProfileIcon(username: member.name.toString()),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 20, 0, 0),
                    child: Text(
                      member.name,
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
                formatter.format(comment.date).toString(),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
          child: Text(comment.content),
        ),
      ],
    );
  }
}
