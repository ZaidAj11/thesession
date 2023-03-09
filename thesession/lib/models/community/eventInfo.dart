// To parse this JSON data, do
//
//     final eventInfo = eventInfoFromJson(jsonString);

import 'dart:convert';

import '../../utils/objects.dart';

EventInfo eventInfoFromJson(String str) => EventInfo.fromJson(json.decode(str));

String eventInfoToJson(EventInfo data) => json.encode(data.toJson());

class EventInfo {
  EventInfo({
    required this.format,
    required this.id,
    required this.name,
    required this.url,
    required this.member,
    required this.date,
    required this.dtstart,
    required this.dtend,
    required this.latitude,
    required this.longitude,
    required this.venue,
    required this.town,
    required this.area,
    required this.country,
    required this.comments,
  });

  String format;
  int id;
  String name;
  String url;
  Member member;
  DateTime date;
  DateTime dtstart;
  DateTime dtend;
  double latitude;
  double longitude;
  Venue venue;
  Area town;
  Area area;
  Area country;
  List<Comment> comments;

  factory EventInfo.fromJson(Map<String, dynamic> json) => EventInfo(
        format: json["format"],
        id: json["id"],
        name: json["name"],
        url: json["url"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
        dtstart: DateTime.parse(json["dtstart"]),
        dtend: DateTime.parse(json["dtend"]),
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        venue: Venue.fromJson(json["venue"]),
        town: Area.fromJson(json["town"]),
        area: Area.fromJson(json["area"]),
        country: Area.fromJson(json["country"]),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "id": id,
        "name": name,
        "url": url,
        "member": member.toJson(),
        "date": date.toIso8601String(),
        "dtstart": dtstart.toIso8601String(),
        "dtend": dtend.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "venue": venue.toJson(),
        "town": town.toJson(),
        "area": area.toJson(),
        "country": country.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}
