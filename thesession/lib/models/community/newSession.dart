// To parse this JSON data, do
//
//     final newSessions = newSessionsFromJson(jsonString);

import 'dart:convert';

NewSession newSessionsFromJson(String str) =>
    NewSession.fromJson(json.decode(str));

String newSessionsToJson(NewSession data) => json.encode(data.toJson());

class NewSession {
  NewSession({
    required this.format,
    required this.pages,
    required this.page,
    required this.total,
    required this.sessions,
  });

  String format;
  int pages;
  int page;
  int total;
  List<Session> sessions;

  factory NewSession.fromJson(Map<String, dynamic> json) => NewSession(
        format: json["format"],
        pages: json["pages"],
        page: json["page"],
        total: json["total"],
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "pages": pages,
        "page": page,
        "total": total,
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
      };
}

class Session {
  Session({
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
  });

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

  factory Session.fromJson(Map<String, dynamic> json) => Session(
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
      );

  Map<String, dynamic> toJson() => {
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
