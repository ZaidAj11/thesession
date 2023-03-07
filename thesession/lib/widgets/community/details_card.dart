import 'package:flutter/material.dart';

import '../../models/community/newSession.dart';

class DetailsCard extends StatelessWidget {
  final Session session;
  const DetailsCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Created by:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(session.member.name)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Venue:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(session.venue.name),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Where:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(getAddress(session)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "When:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(session.date.toIso8601String()),
          ],
        ),
      ],
    );
  }

  String getAddress(Session session) {
    return "${session.area.name},\n${session.town.name},\n${session.country.name}";
  }
}
