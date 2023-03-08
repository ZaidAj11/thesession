import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thesession/models/tunes/popularTune.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PopularTuneCard extends StatelessWidget {
  const PopularTuneCard({super.key, required this.popTune});
  final PopularTune popTune;
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
                popTune.name,
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
              Text(popTune.type),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Last Updated By:"),
              Text(popTune.member.name),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tunebooks:"),
              Text(popTune.tunebooks.toString()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatter.format(popTune.date).toString(),
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
              new InkWell(
                  child: new Text(
                    'Webview',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () => _launchUrl(Uri.parse(popTune.url))),
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
