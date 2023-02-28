import 'dart:collection';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesession/pages/data_analytics/sessions_analytics_page.dart';

import '../models/data_analytics/SessionData.dart';
import '../models/data_analytics/SessionData.dart';

class DataManager {
  final db = FirebaseFirestore.instance;
  final math = Random();
  List<SessionData> _sessionData = [];

  Future<List<ItemCountryData>> getSessionToCountrySections() async {
    HashSet<Color> colorsUsed;
    HashMap<String, ItemCountryData> countryToItemMap =
        new HashMap<String, ItemCountryData>();
    for (var sessionPost in _sessionData) {
      if (!countryToItemMap.containsKey(sessionPost.country)) {
        countryToItemMap[sessionPost.country] = new ItemCountryData(
            sessionPost.country,
            1,
            Color((math.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
      } else {
        countryToItemMap.update(
          sessionPost.country,
          (value) => ItemCountryData(
            value.item,
            value.count + 1,
            value.color,
          ),
        );
      }
    }
    return countryToItemMap.values.toList();
  }

  Future<bool> setSessionData() async {
    final docRef = db.collection("sessions").doc("sessions_data_dump");
    bool isReady = await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        var jsonString = data["dump"].toString();
        _sessionData.addAll(sessionDataFromJson(jsonString).sessions);
        return true;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return isReady;
  }
}

class ItemCountryData {
  String item;
  int count;
  Color color;
  ItemCountryData(this.item, this.count, this.color);
}
