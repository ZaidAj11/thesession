import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/widgets/community/comment_card.dart';
import 'package:thesession/widgets/community/details_card.dart';

import '../../main.dart';
import '../../models/community/eventInfo.dart';
import '../../models/community/newEvent.dart';
import '../../utils/objects.dart';

class EventInfoPage extends StatefulWidget {
  final Event event;
  const EventInfoPage({super.key, required this.event});
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

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  List<Comment> comments = [];

  Future<bool> GetData() async {
    Uri uri = Uri.parse(widget.event.url + "?format=json");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final EventInfo result = eventInfoFromJson(response.body);
      comments = result.comments;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var initialLocation =
        LatLng(widget.event.latitude!, widget.event.longitude!);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.event.venue.name),
        backgroundColor: AppColours.DefaultDarkColour,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: initialLocation,
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("marker1"),
                    position: initialLocation,
                    draggable: true,
                    onDragEnd: (value) {
                      // value is the new position
                    },
                    // To do: custom marker icon
                  ),
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EventInfoPage.getDetailsCardForEvent(widget.event),
            ),
            Divider(
              thickness: 2,
            ),
            const Text(
              "Comments",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                future: GetData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return CommentCard(
                            member: comments[index].member,
                            comment: comments[index]);
                      },
                      itemCount: comments.length,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
