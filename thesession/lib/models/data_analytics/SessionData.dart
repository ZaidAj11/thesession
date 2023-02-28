// To parse this JSON data, do
//
//     final sessionData = sessionDataFromJson(jsonString);

import 'dart:convert';

SessionDataDump sessionDataFromJson(String str) =>
    SessionDataDump.fromJson(json.decode(str));

String sessionDataToJson(SessionDataDump data) => json.encode(data.toJson());

class SessionDataDump {
  SessionDataDump({
    required this.sessions,
  });

  List<SessionData> sessions;

  factory SessionDataDump.fromJson(Map<String, dynamic> json) =>
      SessionDataDump(
        sessions: List<SessionData>.from(
            json["sessions"].map((x) => SessionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
      };
}

class SessionData {
  SessionData({
    required this.id,
    required this.name,
    required this.address,
    required this.town,
    required this.area,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.date,
  });

  String id;
  String name;
  String address;
  String town;
  String area;
  String country;
  String latitude;
  String longitude;
  DateTime date;

  factory SessionData.fromJson(Map<String, dynamic> json) => SessionData(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        town: json["town"],
        area: json["area"],
        country: json["country"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "town": town,
        "area": area,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "date": date.toIso8601String(),
      };
}
