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
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Created by: ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                createdBy,
                textAlign: TextAlign.right,
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Venue: ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      venue,
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      area?.name ?? '',
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      town?.name ?? '',
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      country?.name ?? '',
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "When: ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(date.toIso8601String().split('T')[0]),
            ],
          ),
        ],
      ),
    );
  }
}
