// To parse this JSON data, do
//
//     final popularTuneData = popularTuneDataFromJson(jsonString);

import 'dart:convert';

PopularTuneData popularTuneDataFromJson(String str) =>
    PopularTuneData.fromJson(json.decode(str));

String popularTuneDataToJson(PopularTuneData data) =>
    json.encode(data.toJson());

class PopularTuneData {
  PopularTuneData({
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
  List<PopularTune> tunes;

  factory PopularTuneData.fromJson(Map<String, dynamic> json) =>
      PopularTuneData(
        format: json["format"],
        perpage: json["perpage"],
        pages: json["pages"],
        page: json["page"],
        total: json["total"],
        tunes: List<PopularTune>.from(
            json["tunes"].map((x) => PopularTune.fromJson(x))),
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

class PopularTune {
  PopularTune({
    required this.id,
    required this.name,
    required this.url,
    required this.member,
    required this.date,
    required this.type,
    required this.tunebooks,
  });

  int id;
  String name;
  String url;
  Member member;
  DateTime date;
  String type;
  int tunebooks;

  factory PopularTune.fromJson(Map<String, dynamic> json) => PopularTune(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
        type: json["type"],
        tunebooks: json["tunebooks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "member": member.toJson(),
        "date": date.toIso8601String(),
        "type": type,
        "tunebooks": tunebooks,
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
