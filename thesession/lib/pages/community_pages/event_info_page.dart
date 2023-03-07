import 'package:flutter/material.dart';

import '../../main.dart';

class EventInfoPage extends StatelessWidget {
  final String title;
  const EventInfoPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title),
        backgroundColor: AppColours.DefaultDarkColour,
      ),
      body: Center(
        child: Text("This is the Event info page"),
      ),
    );
  }
}
