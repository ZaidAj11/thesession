import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

import '../../models/community/newEvent.dart';
import '../../models/community/newSession.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final String address;
  const EventCard({super.key, required this.event, required this.address});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: (Colors.grey[700])!,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(20)
            //color: Colors.grey[400],
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: CountryFlags.flag(
                'CA',
                width: 64,
                height: 48,
                borderRadius: 12,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 20, 8, 0),
                  child: Text(
                    widget.event.venue.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Text(
                    "Test",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
