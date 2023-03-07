import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/widgets/tune_display_card.dart';
import '../../models/tunes/newTune.dart';

import '../../models/tunes/tuneInfo.dart';

class NewTunesPage extends StatefulWidget {
  const NewTunesPage({Key? key}) : super(key: key);

  @override
  State<NewTunesPage> createState() => _NewTunesPageState();
}

class _NewTunesPageState extends State<NewTunesPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  bool _isFirstLoadRunning = false;
  int _pageNum = 1;
  late int _totalPages;

  List<Post> newTunes = [];

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
        'https://thesession.org/tunes/new?format=json&perpage=20&page=${_pageNum}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = newTuneDataFromJson(response.body);
      List<Post> tempNewtunes = [];
      for (int i = 0; i < result.settings.length; i++) {
        tempNewtunes.add(await getNewTune(
            result.settings[i].tune.id, result.settings[i].id));
      }
      if (!isRefresh) {
        newTunes.addAll(tempNewtunes);
      } else {
        newTunes = tempNewtunes;
      }
      newTunes.sort((a, b) => b.date.compareTo(a.date));
      _pageNum++;
      _totalPages = result.pages;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  Future<Post> getNewTune(int tuneId, int settingId) async {
    Uri uri = Uri.parse(
        "https://thesession.org/tunes/${tuneId}?format=json#setting'${settingId}");
    final response = await http.get(uri);
    final TuneInfo result = tuneInfoFromJson(response.body);

    return result.posts.length > 0
        ? result.posts.firstWhere((i) => i.id == settingId)
        : Post(
            id: 0,
            url: 'url',
            key: 'key',
            abc: 'abc',
            member: Member(id: 0, name: 'name', url: 'url'),
            date: DateTime.now());
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
              final Post newTune = newTunes[index];
              return TuneCard(post: newTune);
            },
            separatorBuilder: (context, index) => Container(
                  color: Colors.black,
                  height: 3,
                ),
            itemCount: newTunes.length),
      ),
    );
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    // Post item = newTunes[indexOfItem];
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => TuneInfoPage(
    //       tuneId: item.id.toString(),
    //       settingId: item.id.toString(),
    //       isNewTune: true,
    //     ),
    //   ),
    // );
  }
}
