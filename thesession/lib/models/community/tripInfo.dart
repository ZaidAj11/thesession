// To parse this JSON data, do
//
//     final tripInfo = tripInfoFromJson(jsonString);

import 'dart:convert';

import '../../utils/objects.dart';

TripInfo tripInfoFromJson(String str) => TripInfo.fromJson(json.decode(str));

String tripInfoToJson(TripInfo data) => json.encode(data.toJson());

class TripInfo {
  TripInfo({
    required this.format,
    required this.id,
    required this.url,
    required this.name,
    required this.member,
    required this.date,
    required this.dtstart,
    required this.dtend,
    required this.latitude,
    required this.longitude,
    required this.comments,
  });

  String format;
  int id;
  String url;
  String name;
  Member member;
  DateTime date;
  DateTime dtstart;
  DateTime dtend;
  double latitude;
  double longitude;
  List<Comment> comments;

  factory TripInfo.fromJson(Map<String, dynamic> json) => TripInfo(
        format: json["format"],
        id: json["id"],
        url: json["url"],
        name: json["name"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
        dtstart: DateTime.parse(json["dtstart"]),
        dtend: DateTime.parse(json["dtend"]),
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "id": id,
        "url": url,
        "name": name,
        "member": member.toJson(),
        "date": date.toIso8601String(),
        "dtstart": dtstart.toIso8601String(),
        "dtend": dtend.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}
