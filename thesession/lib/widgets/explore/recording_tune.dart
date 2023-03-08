import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thesession/models/tunes/popularTune.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/tunes/recordingTune.dart';

class RecordingTuneCard extends StatelessWidget {
  const RecordingTuneCard({super.key, required this.recording});
  final Recording recording;
  static DateFormat formatter = DateFormat('dd-MM-yyyy');

  static List<Widget> icons = [
    Icon(Icons.music_note_rounded),
    MusicNotes(),
    Icon(Icons.music_video_rounded),
    Icon(Icons.piano_rounded)
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icons[Random().nextInt(3)],
              Text(
                recording.name,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Type:"),
              Text(recording.type),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Last Updated By:"),
              Text(recording.member.name),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatter.format(recording.date).toString(),
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
              new InkWell(
                  child: new Text(
                    'Webview',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () => _launchUrl(Uri.parse(recording.url))),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

class MusicNotes extends StatelessWidget {
  const MusicNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.music_note_rounded),
        const Icon(
          Icons.music_note_rounded,
          size: 16,
        )
      ],
    );
  }
}
