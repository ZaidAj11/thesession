// To parse this JSON data, do
//
//     final youtubeVideo = youtubeVideoFromJson(jsonString);

import 'dart:convert';

YoutubeVideo youtubeVideoFromJson(String str) =>
    YoutubeVideo.fromJson(json.decode(str));

String youtubeVideoToJson(YoutubeVideo data) => json.encode(data.toJson());

class YoutubeVideo {
  YoutubeVideo({
    required this.kind,
    required this.etag,
    required this.items,
    required this.pageInfo,
  });

  String kind;
  String etag;
  List<Item> items;
  PageInfo pageInfo;

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) => YoutubeVideo(
        kind: json["kind"],
        etag: json["etag"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pageInfo": pageInfo.toJson(),
      };
}

class Item {
  Item({
    required this.kind,
    required this.etag,
    required this.id,
    required this.player,
  });

  String kind;
  String etag;
  String id;
  Player player;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        player: Player.fromJson(json["player"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "player": player.toJson(),
      };
}

class Player {
  Player({
    required this.embedHtml,
  });

  String embedHtml;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        embedHtml: json["embedHtml"],
      );

  Map<String, dynamic> toJson() => {
        "embedHtml": embedHtml,
      };
}

class PageInfo {
  PageInfo({
    required this.totalResults,
    required this.resultsPerPage,
  });

  int totalResults;
  int resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
      };
}
