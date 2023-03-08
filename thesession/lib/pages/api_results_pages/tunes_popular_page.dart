import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/models/tunes/popularTune.dart';
import 'package:thesession/main.dart';
import 'package:thesession/pages/api_results_pages/tune_info_page.dart';
import 'package:thesession/widgets/explore/popular_tune_card.dart';
import '../../models/tunes/newTune.dart';

class PopularTunesPage extends StatefulWidget {
  const PopularTunesPage({Key? key}) : super(key: key);

  @override
  State<PopularTunesPage> createState() => _PopularTunesPageState();
}

class _PopularTunesPageState extends State<PopularTunesPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  bool _isFirstLoadRunning = false;
  int _pageNum = 1;
  late int _totalPages;

  List<PopularTune> popularTunes = [];

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
        'https://thesession.org/tunes/popular?format=json&perpage=20&page=${_pageNum}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = popularTuneDataFromJson(response.body);
      if (!isRefresh) {
        popularTunes.addAll(result.tunes);
      } else {
        popularTunes = result.tunes;
      }
      _pageNum++;
      _totalPages = result.pages;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
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
              final popTune = popularTunes[index];
              return GestureDetector(
                child: PopularTuneCard(popTune: popTune),
                onTap: () {
                  _navigateToPost(context, index);
                },
              );
            },
            separatorBuilder: (context, index) => Divider(
                  height: 1,
                ),
            itemCount: popularTunes.length),
      ),
    );
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    var item = popularTunes[indexOfItem];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TuneInfoPage(
          tuneId: item.id.toString(),
          settingId: '',
          isNewTune: false,
        ),
      ),
    );
  }
}
