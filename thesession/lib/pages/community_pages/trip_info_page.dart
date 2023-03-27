import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thesession/models/community/newTrip.dart';
import 'package:thesession/models/community/tripInfo.dart';
import 'package:thesession/widgets/community/trip_details_card.dart';
import 'package:thesession/widgets/community/trip_display_card.dart';
import '../../main.dart';
import '../../utils/objects.dart';
import '../../widgets/community/comment_card.dart';
import 'package:http/http.dart' as http;

class TripInfoPage extends StatefulWidget {
  final Trip trip;
  const TripInfoPage({Key? key, required this.trip}) : super(key: key);

  @override
  _TripInfoPageState createState() => _TripInfoPageState();
}

class _TripInfoPageState extends State<TripInfoPage> {
  List<Comment> comments = [];
  LatLng? initialLocation;
  Future<bool> getData() async {
    Uri uri = Uri.parse(widget.trip.url + "?format=json");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final TripInfo result = tripInfoFromJson(response.body);
      comments = result.comments;
      initialLocation = LatLng(result.latitude, result.longitude);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.trip.name),
        backgroundColor: AppColours.DefaultDarkColour,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 280,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: initialLocation!,
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("marker1"),
                          position: initialLocation!,
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
                    child: TripCard.getDetailsCardForTrip(widget.trip),
                  ),
                  const Divider(
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
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CommentCard(
                            member: comments[index].member,
                            comment: comments[index]);
                      },
                      itemCount: comments.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
