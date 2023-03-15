// To parse this JSON data, do
//
//     final tuneInfo = tuneInfoFromJson(jsonString);

import 'dart:convert';

TuneInfo tuneInfoFromJson(String str) {
  try {
    return TuneInfo.fromJson(json.decode(str));
  } catch (Exception) {
    return new TuneInfo(
        format: '',
        id: 0,
        name: 'name',
        url: 'url',
        member: Member(id: 0, name: 'name', url: 'url'),
        date: DateTime.now(),
        type: 'type',
        tunebooks: 0,
        recordings: 0,
        collections: 0,
        aliases: [],
        posts: [],
        comments: []);
  }
}

String tuneInfoToJson(TuneInfo data) => json.encode(data.toJson());

class TuneInfo {
  TuneInfo({
    required this.format,
    required this.id,
    required this.name,
    required this.url,
    required this.member,
    required this.date,
    required this.type,
    required this.tunebooks,
    required this.recordings,
    required this.collections,
    required this.aliases,
    required this.posts,
    required this.comments,
  });

  String format;
  int id;
  String name;
  String url;
  Member member;
  DateTime? date;
  String type;
  int tunebooks;
  int recordings;
  int collections;
  List<String> aliases;
  List<Post> posts;
  List<Comment> comments;

  factory TuneInfo.fromJson(Map<String, dynamic> json) => TuneInfo(
        format: json["format"],
        id: json["id"],
        name: json["name"],
        url: json["url"],
        member: Member.fromJson(json["member"]),
        date: DateTime.tryParse(json["date"]),
        type: json["type"],
        tunebooks: json["tunebooks"],
        recordings: json["recordings"],
        collections: json["collections"],
        aliases: List<String>.from(json["aliases"].map((x) => x)),
        posts: List<Post>.from(json["settings"].map((x) => Post.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "id": id,
        "name": name,
        "url": url,
        "member": member.toJson(),
        "date": date?.toIso8601String(),
        "type": type,
        "tunebooks": tunebooks,
        "recordings": recordings,
        "collections": collections,
        "aliases": List<dynamic>.from(aliases.map((x) => x)),
        "settings": List<dynamic>.from(posts.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
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

  factory Member.fromJson(Map<String, dynamic> json) {
    try {
      return Member(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );
    } catch (Exception) {
      return new Member(id: 1, name: 'Empty', url: 'Empty');
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}

class Post {
  Post({
    required this.id,
    required this.url,
    required this.key,
    required this.abc,
    required this.member,
    required this.date,
  });

  int id;
  String url;
  String key;
  String abc;
  Member member;
  DateTime date;
  TuneInfo? tuneInfo;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        url: json["url"],
        key: json["key"],
        abc: json["abc"],
        member: Member.fromJson(json["member"]),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "key": key,
        "abc": abc,
        "member": member.toJson(),
        "date": date.toIso8601String(),
      };
}
