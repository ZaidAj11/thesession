import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesession/models/data_analytics/TuneData.dart';
import 'package:thesession/pages/data_analytics/sessions_analytics_page.dart';
import '../models/data_analytics/SessionData.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/data_analytics/SessionData.dart';

class DataManager {
  final db = FirebaseFirestore.instance;
  final math = Random();
  List<SessionData> _sessionData = [];
  List<TuneData> _tuneData = [];

  Future<List<ItemCountryData>> getTuneSetSections() async {
    HashSet<Color> colorsUsed;
    HashMap<String, ItemCountryData> countryToItemMap =
        new HashMap<String, ItemCountryData>();
    for (var tunePost in _tuneData) {
      if (!countryToItemMap.containsKey(tunePost.type.name)) {
        countryToItemMap[tunePost.type.name] = ItemCountryData(
            tunePost.type.name,
            1,
            Color((math.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
      } else {
        countryToItemMap.update(
          tunePost.type.name,
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

  Future<List<ItemCountryData>> getTuneToDateSections() async {
    HashSet<Color> colorsUsed;
    HashMap<int, ItemCountryData> countryToItemMap =
        new HashMap<int, ItemCountryData>();
    for (var tunePost in _tuneData) {
      if (tunePost.date == null) continue;
      if (!countryToItemMap.containsKey(tunePost.date?.year)) {
        countryToItemMap[tunePost.date!.year] = ItemCountryData(
            tunePost.date!.year.toString(),
            1,
            Color((math.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
      } else {
        countryToItemMap.update(
          tunePost.date!.year,
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

  Future<List<ItemCountryData>> getTuneToTypeSections() async {
    HashSet<Color> colorsUsed;
    HashMap<String, ItemCountryData> countryToItemMap =
        new HashMap<String, ItemCountryData>();
    for (var tunePost in _tuneData) {
      if (!countryToItemMap.containsKey(tunePost.type.name)) {
        countryToItemMap[tunePost.type.name] = ItemCountryData(
            tunePost.type.name,
            1,
            Color((math.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
      } else {
        countryToItemMap.update(
          tunePost.type.name,
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

  Future<List<ItemCountryData>> getSessionToCountySections() async {
    HashSet<Color> colorsUsed;
    HashMap<String, ItemCountryData> countyToItemMap =
        new HashMap<String, ItemCountryData>();
    for (var sessionPost in _sessionData) {
      if (!countyToItemMap.containsKey(sessionPost.area)) {
        countyToItemMap[sessionPost.area] = new ItemCountryData(
            sessionPost.area,
            1,
            Color((math.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
      } else {
        countyToItemMap.update(
          sessionPost.area,
          (value) => ItemCountryData(
            value.item,
            value.count + 1,
            value.color,
          ),
        );
      }
    }
    return countyToItemMap.values.toList();
  }

  Future<bool> setTuneSetsData() async {
    var jsonString = await rootBundle.loadString('assets/sets.json');
    _tuneData.addAll(tuneDataFromJson(jsonString).tunes);
    return true;
  }

  Future<bool> setTuneData() async {
    var jsonString = await rootBundle.loadString('assets/tunes.json');
    _tuneData.addAll(tuneDataFromJson(jsonString).tunes);
    return true;
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
