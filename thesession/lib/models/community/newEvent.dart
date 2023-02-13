// To parse this JSON data, do
//
//     final newEvent = newEventFromJson(jsonString);

import 'dart:convert';

NewEvent newEventFromJson(String str) => NewEvent.fromJson(json.decode(str));

String newEventToJson(NewEvent data) => json.encode(data.toJson());

class NewEvent {
  NewEvent({
    required this.format,
    required this.perpage,
    required this.pages,
    required this.page,
    required this.total,
    required this.events,
  });

  String format;
  String perpage;
  int pages;
  int page;
  int total;
  List<Event> events;

  factory NewEvent.fromJson(Map<String, dynamic> json) => NewEvent(
        format: json["format"],
        perpage: json["perpage"],
        pages: json["pages"],
        page: json["page"],
        total: json["total"],
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "perpage": perpage,
        "pages": pages,
        "page": page,
        "total": total,
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  Event({
    required this.id,
    required this.name,
    required this.url,
    required this.member,
    required this.date,
    required this.dtstart,
    required this.dtend,
    required this.venue,
    this.latitude,
    this.longitude,
    this.town,
    this.area,
    this.country,
  });

  int id;
  String name;
  String url;
  Member member;
  DateTime date;
  DateTime dtstart;
  DateTime dtend;
  Venue venue;
  double? latitude;
  double? longitude;
  Area? town;
  Area? area;
  Area? country;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
        dtstart: DateTime.parse(json["dtstart"]),
        dtend: DateTime.parse(json["dtend"]),
        venue: Venue.fromJson(json["venue"]),
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        town: json["town"] == null ? null : Area.fromJson(json["town"]),
        area: json["area"] == null ? null : Area.fromJson(json["area"]),
        country:
            json["country"] == null ? null : Area.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "member": member.toJson(),
        "date": date.toIso8601String(),
        "dtstart": dtstart.toIso8601String(),
        "dtend": dtend.toIso8601String(),
        "venue": venue.toJson(),
        "latitude": latitude,
        "longitude": longitude,
        "town": town?.toJson(),
        "area": area?.toJson(),
        "country": country?.toJson(),
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
    required this.name,
    this.id,
    this.telephone,
    this.email,
    this.web,
  });

  String name;
  int? id;
  String? telephone;
  String? email;
  String? web;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        name: json["name"],
        id: json["id"],
        telephone: json["telephone"],
        email: json["email"],
        web: json["web"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "telephone": telephone,
        "email": email,
        "web": web,
      };
}
