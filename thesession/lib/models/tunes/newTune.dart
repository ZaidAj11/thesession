// To parse this JSON data, do
//
//     final newTuneData = newTuneDataFromJson(jsonString);

import 'dart:convert';

NewTuneData newTuneDataFromJson(String str) =>
    NewTuneData.fromJson(json.decode(str));

String newTuneDataToJson(NewTuneData data) => json.encode(data.toJson());

class NewTuneData {
  NewTuneData({
    required this.format,
    required this.perpage,
    required this.pages,
    required this.page,
    required this.total,
    required this.settings,
  });

  String format;
  String perpage;
  int pages;
  int page;
  int total;
  List<NewTune> settings;

  factory NewTuneData.fromJson(Map<String, dynamic> json) => NewTuneData(
        format: json["format"],
        perpage: json["perpage"],
        pages: json["pages"],
        page: json["page"],
        total: json["total"],
        settings: List<NewTune>.from(
            json["settings"].map((x) => NewTune.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "perpage": perpage,
        "pages": pages,
        "page": page,
        "total": total,
        "settings": List<dynamic>.from(settings.map((x) => x.toJson())),
      };
}

class NewTune {
  NewTune({
    required this.id,
    required this.url,
    required this.key,
    required this.member,
    required this.date,
    required this.tune,
  });

  int id;
  String url;
  String key;
  Member member;
  DateTime date;
  Member tune;

  factory NewTune.fromJson(Map<String, dynamic> json) => NewTune(
        id: json["id"],
        url: json["url"],
        key: json["key"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
        tune: Member.fromJson(json["tune"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "key": key,
        "member": member.toJson(),
        "date": date.toIso8601String(),
        "tune": tune.toJson(),
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
