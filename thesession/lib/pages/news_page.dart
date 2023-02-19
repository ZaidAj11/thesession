import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/models/news/newsModel.dart';
import 'package:thesession/models/tunes/popularTune.dart';
import 'package:thesession/main.dart';
import 'package:thesession/pages/api_results_pages/tune_info_page.dart';
import 'package:thesession/widgets/my_appbar.dart';
import 'package:thesession/widgets/news/news_article_card.dart';
import '../../models/tunes/newTune.dart';
import '../widgets/side_drawer.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);
  final API_KEY = "4045d192e3aca5dd1b0ebecae109fb3f";
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final user = FirebaseAuth.instance.currentUser;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  bool _isFirstLoadRunning = false;
  int _pageNum = 1;
  late int _totalPages;

  List<Article> articles = [];

  Future<bool> GetData({bool isRefresh = false}) async {
    if (isRefresh) {
      _pageNum = 1;
    } else {
      if (_pageNum >= _totalPages) {
        refreshController.loadNoData();
        return true;
      }
    }
    Uri uri = Uri.parse(
        'https://gnews.io/api/v4/search?q="irish%20music"%20OR%20"irish%20tunes"&lang=en&country=us&max=10&apikey=' +
            widget.API_KEY);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = newsFromJson(response.body);
      if (!isRefresh) {
        articles.addAll(result.articles);
      } else {
        articles = result.articles;
      }
      _pageNum++;
      _totalPages = result.totalArticles;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(
        userName: user?.email,
      ),
      appBar: MyAppBar(
        dropdown: Text("News - Irish Tunes"),
      ),
      body: SafeArea(
        child: SmartRefresher(
          enablePullUp: true,
          controller: refreshController,
          onRefresh: () async {
            final result = await GetData(isRefresh: true);
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result = await GetData();
            if (result) {
              refreshController.loadComplete();
            } else {
              refreshController.loadFailed();
            }
          },
          child: ListView.separated(
              itemBuilder: (context, index) {
                final article = articles[index];
                return NewsArticleCard(
                  image: Image.network(
                    article.imageUrl,
                    width: 90,
                    height: 90,
                  ),
                  article: article,
                );
              },
              separatorBuilder: (context, index) => Divider(
                    height: 1,
                  ),
              itemCount: articles.length),
        ),
      ),
    );
  }
}
