// To parse this JSON data, do
//
//     final recordingTuneData = recordingTuneDataFromJson(jsonString);

import 'dart:convert';

RecordingTuneData recordingTuneDataFromJson(String str) =>
    RecordingTuneData.fromJson(json.decode(str));

String recordingTuneDataToJson(RecordingTuneData data) =>
    json.encode(data.toJson());

class RecordingTuneData {
  RecordingTuneData({
    required this.format,
    required this.perpage,
    required this.pages,
    required this.page,
    required this.total,
    required this.tunes,
  });

  String format;
  String perpage;
  int pages;
  int page;
  int total;
  List<Recording> tunes;

  factory RecordingTuneData.fromJson(Map<String, dynamic> json) =>
      RecordingTuneData(
        format: json["format"],
        perpage: json["perpage"],
        pages: json["pages"],
        page: json["page"],
        total: json["total"],
        tunes: List<Recording>.from(
            json["tunes"].map((x) => Recording.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "perpage": perpage,
        "pages": pages,
        "page": page,
        "total": total,
        "tunes": List<dynamic>.from(tunes.map((x) => x.toJson())),
      };
}

class Recording {
  Recording({
    required this.id,
    required this.name,
    required this.url,
    required this.member,
    required this.date,
    required this.type,
  });

  int id;
  String name;
  String url;
  Member member;
  DateTime date;
  String type;

  factory Recording.fromJson(Map<String, dynamic> json) => Recording(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "member": member.toJson(),
        "date": date.toIso8601String(),
        "type": type,
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
