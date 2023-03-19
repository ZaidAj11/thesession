import 'package:flutter/material.dart';

import '../../utils/objects.dart';

class DetailsCard extends StatelessWidget {
  final String where;
  final String createdBy;
  final String venue;
  final Area? area;
  final Area? town;
  final Area? country;
  final DateTime date;

  const DetailsCard(
      {super.key,
      required this.where,
      required this.createdBy,
      required this.venue,
      required this.area,
      required this.town,
      required this.country,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Created by: ",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(createdBy)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Venue: ",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(venue),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Where: ",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text("${area!.name},\n${town!.name},\n${country!.name}"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "When: ",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(date.toIso8601String().split('T')[0]),
          ],
        ),
      ],
    );
  }
}
