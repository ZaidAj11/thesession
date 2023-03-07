import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/models/community/newEvent.dart';
import 'package:thesession/models/community/sessionInfo.dart';
import 'package:thesession/widgets/community/comment_card.dart';
import 'package:thesession/widgets/community/details_card.dart';

import '../../main.dart';
import '../../models/community/newSession.dart';

class SessionInfoPage extends StatefulWidget {
  final Session session;
  const SessionInfoPage({super.key, required this.session});

  @override
  State<SessionInfoPage> createState() => _SessionInfoPageState();
}

class _SessionInfoPageState extends State<SessionInfoPage> {
  List<Comment> comments = [];

  Future<bool> GetData() async {
    Uri uri = Uri.parse(widget.session.url + "?format=json");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final SessionInfo result = sessionInfoFromJson(response.body);
      comments = result.comments;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var initialLocation =
        LatLng(widget.session.latitude, widget.session.longitude);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.session.venue.name),
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
            SizedBox(
              height: 15,
            ),
            Text(
              "Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            DetailsCard(session: widget.session),
            Text(
              "Comments",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
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
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
