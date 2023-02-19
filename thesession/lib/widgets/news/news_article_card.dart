import 'package:flutter/material.dart';
import 'package:thesession/models/news/newsModel.dart';

class NewsArticleCard extends StatelessWidget {
  final Image image;
  final Article article;
  const NewsArticleCard(
      {super.key, required this.image, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            image,
            Expanded(
              child: Text(
                article.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Text(
          article.description,
          style: TextStyle(fontWeight: FontWeight.w200),
        )
      ],
    );
  }
}
