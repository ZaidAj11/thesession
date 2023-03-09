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
