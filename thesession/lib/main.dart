import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thesession/auth/main_page.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  _setTargetPlatformForDesktop();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'theSession',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
      ),
      darkTheme: ThemeData(textTheme: GoogleFonts.manropeTextTheme()),
      home: const MainPage(),
    );
  }

  static bool checkIfDarkModeEnabled(context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

class AppColours {
  static final Color DefaultDarkColour = Color.fromARGB(255, 47, 47, 47);
  static final Color DefaultWhiteColour = Color.fromARGB(255, 218, 218, 218);
}
