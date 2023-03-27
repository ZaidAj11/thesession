// To parse this JSON data, do
//
//     final newTrip = newTripFromJson(jsonString);

import 'dart:convert';

import '../../utils/objects.dart';

NewTrip newTripFromJson(String str) => NewTrip.fromJson(json.decode(str));

String newTripToJson(NewTrip data) => json.encode(data.toJson());

class NewTrip {
  NewTrip({
    required this.format,
    required this.pages,
    required this.page,
    required this.total,
    required this.trips,
  });

  String format;
  int pages;
  int page;
  int total;
  List<Trip> trips;

  factory NewTrip.fromJson(Map<String, dynamic> json) => NewTrip(
        format: json["format"],
        pages: json["pages"],
        page: json["page"],
        total: json["total"],
        trips: List<Trip>.from(json["trips"].map((x) => Trip.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "pages": pages,
        "page": page,
        "total": total,
        "trips": List<dynamic>.from(trips.map((x) => x.toJson())),
      };
}

class Trip {
  Trip({
    required this.id,
    required this.url,
    required this.name,
    required this.member,
    required this.date,
    required this.dtstart,
    required this.dtend,
  });

  int id;
  String url;
  String name;
  Member member;
  DateTime date;
  DateTime dtstart;
  DateTime dtend;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
        dtstart: DateTime.parse(json["dtstart"]),
        dtend: DateTime.parse(json["dtend"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "member": member.toJson(),
        "date": date.toIso8601String(),
        "dtstart": dtstart.toIso8601String(),
        "dtend": dtend.toIso8601String(),
      };
}
