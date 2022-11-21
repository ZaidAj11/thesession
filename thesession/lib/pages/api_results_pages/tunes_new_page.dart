import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import '../../http_requests/tunes/newTune.dart';

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

  List<NewTune> newTunes = [];

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
      if (!isRefresh) {
        newTunes.addAll(result.settings);
      } else {
        newTunes = result.settings;
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
              final newTune = newTunes[index];
              return ListTile(
                title: Text(newTune.tune.name.toString()),
                subtitle: Text("By ${newTune.member.name}"),
                trailing: Text(newTune.date.toString()),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: newTunes.length),
      ),
    );
  }
}
