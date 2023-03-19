import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../../models/tunes/tuneInfo.dart';

class TuneInfoCard extends StatelessWidget {
  final TuneInfo tuneInfo;
  const TuneInfoCard({super.key, required this.tuneInfo});
  static DateFormat formatter = DateFormat('dd-MM-yyyy');

  static List<Widget> icons = [
    Icon(Icons.music_note_rounded),
    MusicNotes(),
    Icon(Icons.music_video_rounded),
    Icon(Icons.piano_rounded)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icons[Random().nextInt(3)],
              Text(
                tuneInfo.name,
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
              Text(tuneInfo.type),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Last Updated By:"),
              Text(tuneInfo.member.name),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tunebooks:"),
              Text(tuneInfo.tunebooks.toString()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatter.format(tuneInfo.date!).toString(),
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
              new InkWell(
                  child: new Text(
                    'Webview',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () => _launchUrl(Uri.parse(tuneInfo.url))),
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
