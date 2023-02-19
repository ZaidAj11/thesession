// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    required this.totalArticles,
    required this.articles,
  });

  int totalArticles;
  List<Article> articles;

  factory News.fromJson(Map<String, dynamic> json) => News(
        totalArticles: json["totalArticles"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalArticles": totalArticles,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
  });

  String title;
  String description;
  String content;
  String url;
  String imageUrl;
  DateTime publishedAt;
  Source source;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json["title"],
        description: json["description"],
        content: json["content"],
        url: json["url"],
        imageUrl: json["image"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        source: Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "content": content,
        "url": url,
        "image": imageUrl,
        "publishedAt": publishedAt.toIso8601String(),
        "source": source.toJson(),
      };
}

class Source {
  Source({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
