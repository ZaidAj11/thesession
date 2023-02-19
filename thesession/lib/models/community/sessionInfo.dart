// To parse this JSON data, do
//
//     final sessionInfo = sessionInfoFromJson(jsonString);

import 'dart:convert';

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

class Comment {
  Comment({
    required this.id,
    required this.url,
    required this.subject,
    required this.content,
    required this.member,
    required this.date,
  });

  int id;
  String url;
  String subject;
  String content;
  Member member;
  DateTime date;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        url: json["url"],
        subject: json["subject"],
        content: json["content"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "subject": subject,
        "content": content,
        "member": member.toJson(),
        "date": date.toIso8601String(),
      };
}

class Member {
  Member({
    required this.id,
    required this.name,
    required this.url,
  });

  int id;
  String name;
  String url;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}

class Venue {
  Venue({
    required this.id,
    required this.name,
    required this.telephone,
    required this.email,
    required this.web,
  });

  int id;
  String name;
  String telephone;
  String email;
  String web;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        name: json["name"],
        telephone: json["telephone"],
        email: json["email"],
        web: json["web"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "telephone": telephone,
        "email": email,
        "web": web,
      };
}
