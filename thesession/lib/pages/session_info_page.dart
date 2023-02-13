import 'package:flutter/material.dart';

import '../main.dart';

class SessionInfoPage extends StatelessWidget {
  final String title;
  const SessionInfoPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title),
        backgroundColor: AppColours.DefaultDarkColour,
      ),
      body: Center(
        child: Text("This is the Session info page"),
      ),
    );
  }
}
