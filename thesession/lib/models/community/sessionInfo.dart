// To parse this JSON data, do
//
//     final sessionInfo = sessionInfoFromJson(jsonString);

import 'dart:convert';

import '../../utils/objects.dart';

SessionInfo sessionInfoFromJson(String str) =>
    SessionInfo.fromJson(json.decode(str));

String sessionInfoToJson(SessionInfo data) => json.encode(data.toJson());

class SessionInfo {
  SessionInfo({
    required this.format,
    required this.id,
    required this.url,
    required this.member,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.venue,
    required this.town,
    required this.area,
    required this.country,
    required this.schedule,
    required this.comments,
  });

  String format;
  int id;
  String url;
  Member member;
  DateTime date;
  double latitude;
  double longitude;
  Venue venue;
  Area town;
  Area area;
  Area country;
  List<String> schedule;
  List<Comment> comments;

  factory SessionInfo.fromJson(Map<String, dynamic> json) => SessionInfo(
        format: json["format"],
        id: json["id"],
        url: json["url"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        venue: Venue.fromJson(json["venue"]),
        town: Area.fromJson(json["town"]),
        area: Area.fromJson(json["area"]),
        country: Area.fromJson(json["country"]),
        schedule: List<String>.from(json["schedule"].map((x) => x)),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "id": id,
        "url": url,
        "member": member.toJson(),
        "date": date.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "venue": venue.toJson(),
        "town": town.toJson(),
        "area": area.toJson(),
        "country": country.toJson(),
        "schedule": List<dynamic>.from(schedule.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
