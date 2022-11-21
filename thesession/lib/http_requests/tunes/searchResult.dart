// To parse this JSON data, do
//
//     final searchTune = searchTuneFromJson(jsonString);

import 'dart:convert';

SearchResultTune searchResultTuneFromJson(String str) =>
    SearchResultTune.fromJson(json.decode(str));

String searchTuneToJson(SearchResultTune data) => json.encode(data.toJson());

class SearchResultTune {
  SearchResultTune({
    required this.q,
    required this.format,
    required this.pages,
    required this.page,
    required this.total,
    required this.tunes,
  });

  String q;
  String format;
  int pages;
  int page;
  int total;
  List<TuneFromSearchResult> tunes;

  factory SearchResultTune.fromJson(Map<String, dynamic> json) =>
      SearchResultTune(
        q: json["q"],
        format: json["format"],
        pages: json["pages"],
        page: json["page"],
        total: json["total"],
        tunes: List<TuneFromSearchResult>.from(
            json["tunes"].map((x) => TuneFromSearchResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "q": q,
        "format": format,
        "pages": pages,
        "page": page,
        "total": total,
        "tunes": List<dynamic>.from(tunes.map((x) => x.toJson())),
      };
}

class TuneFromSearchResult {
  TuneFromSearchResult({
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

  factory TuneFromSearchResult.fromJson(Map<String, dynamic> json) =>
      TuneFromSearchResult(
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
