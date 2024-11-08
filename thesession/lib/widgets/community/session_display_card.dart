import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:geocoder/geocoder.dart';
import 'package:thesession/utils/countryCodeGenerator.dart';
import 'package:thesession/utils/geoLocator.dart';
import 'package:thesession/utils/objects.dart';
import 'package:thesession/widgets/community/details_card.dart';
import '../../models/community/newSession.dart';
import '../../pages/community_pages/session_info_page.dart';

class SessionCard extends StatefulWidget {
  final Session session;
  final String address;
  const SessionCard({super.key, required this.session, required this.address});

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
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
      height: 800,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: CountryFlags.flag(
                  getCountryCode(widget.session.country),
                  width: 64,
                  height: 48,
                  borderRadius: 12,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 20, 0, 0),
                  child: Text(
                    widget.session.venue.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
            child: SessionInfoPage.getDetailsCardForSession(widget.session),
          ),
        ],
      ),
    );
  }

  String getCountryCode(Area country) {
    if (CountryCodeGenerator.CountryCodes.containsKey(country.name)) {
      return CountryCodeGenerator.CountryCodes[country.name]!;
    } else
      return 'IE';
  }
}
