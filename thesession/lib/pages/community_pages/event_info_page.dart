import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';

import '../../main.dart';

class EventInfoPage extends StatefulWidget {
  final String title;
  const EventInfoPage({super.key, required this.title});

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  var sheetmusic = "";
  Future<bool> fetchPost() async {
    final response = await http
        .get(Uri.parse("https://thesession.org/tunes/160#setting46381"));
    var document = response.body.toString();
    //sheetmusic = document.getElementById("sheetmusic-canvas16").children;
    //sheetmusic = parse(document).getElementById("sheetmusic-canvas16").innerHtml;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: fetchPost(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (sheetmusic.length > 1) {
              return Html(
                data: sheetmusic,
                backgroundColor: Colors.blue,
              );
            } else
              return CircularProgressIndicator(
                color: Colors.black,
              );
          },
        ),
      ),
    );
  }
}
