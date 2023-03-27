import 'package:flutter/material.dart';

import '../../utils/objects.dart';

class TripDetailsCard extends StatelessWidget {
  final String where;
  final String createdBy;
  final DateTime dateStart;
  final DateTime dateEnd;
  final DateTime date;

  const TripDetailsCard(
      {super.key,
      required this.where,
      required this.createdBy,
      required this.dateStart,
      required this.dateEnd,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date Start: ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(dateStart.toIso8601String().split('T')[0]),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date End: ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(dateEnd.toIso8601String().split('T')[0]),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Posted: ",
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
