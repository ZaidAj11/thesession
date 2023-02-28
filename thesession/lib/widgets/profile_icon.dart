import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:thesession/main.dart';

class ProfileIcon extends StatelessWidget {
  ProfileIcon({Key? key}) : super(key: key);
  final rng = new Random();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Color((rng.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          "P.P",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}