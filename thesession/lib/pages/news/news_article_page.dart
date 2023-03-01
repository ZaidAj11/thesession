import 'package:flutter/material.dart';
import 'package:thesession/models/news/newsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticlePage extends StatelessWidget {
  final Article article;
  const NewsArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  article.description,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20),
                Image.network(article.imageUrl),
                SizedBox(height: 20),
                Text(article.content),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Published At: ${article.publishedAt.toString().split(' ')[0]}',
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                    new InkWell(
                        child: new Text(
                          'Source',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () => _launchUrl(Uri.parse(article.source.url))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
