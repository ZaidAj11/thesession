import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:thesession/pages/community_pages/event_info_page.dart';
import 'package:thesession/widgets/community/trip_details_card.dart';

import '../../models/community/newEvent.dart';
import '../../models/community/newTrip.dart';
import '../../utils/countryCodeGenerator.dart';
import '../../utils/objects.dart';
import 'details_card.dart';

class TripCard extends StatefulWidget {
  const TripCard({super.key, required this.trip});
  final Trip trip;
  @override
  State<TripCard> createState() => _TripCardState();

  static TripDetailsCard getDetailsCardForTrip(Trip trip) {
    return TripDetailsCard(
      where: trip.url,
      createdBy: trip.member.name,
      dateStart: trip.dtstart,
      dateEnd: trip.dtend,
      date: trip.date,
    );
  }
}

class _TripCardState extends State<TripCard> {
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
                  getCountryCode(Area(name: 'Ireland')),
                  width: 64,
                  height: 48,
                  borderRadius: 12,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 8, 0, 0),
                  child: Text(
                    widget.trip.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TripCard.getDetailsCardForTrip(widget.trip),
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
