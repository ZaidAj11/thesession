import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:thesession/pages/community_pages/event_info_page.dart';

import '../../models/community/newEvent.dart';
import '../../utils/countryCodeGenerator.dart';
import '../../utils/objects.dart';
import 'details_card.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final String address;
  const EventCard({super.key, required this.event, required this.address});

  @override
  State<EventCard> createState() => _EventCardState();

  static DetailsCard getDetailsCardForEvent(Event event) {
    return DetailsCard(
      where: event.url,
      createdBy: event.member.name,
      venue: event.venue.name,
      area: event.area,
      town: event.town,
      country: event.country,
      date: event.date,
    );
  }
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: (Colors.grey[700])!,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(20)
          //color: Colors.grey[400],
          ),
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: CountryFlags.flag(
                  getCountryCode(widget.event.country),
                  width: 64,
                  height: 48,
                  borderRadius: 12,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 8, 0, 0),
                  child: Text(
                    widget.event.venue.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: EventInfoPage.getDetailsCardForEvent(widget.event),
          ),
        ],
      ),
    );
  }

  String getCountryCode(Area? country) {
    if (country == null) return 'IE';
    if (CountryCodeGenerator.CountryCodes.containsKey(country?.name)) {
      return CountryCodeGenerator.CountryCodes[country?.name]!;
    } else
      return 'IE';
  }
}
