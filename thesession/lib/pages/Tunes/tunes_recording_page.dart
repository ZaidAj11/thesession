import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/models/tunes/popularTune.dart';
import 'package:thesession/models/tunes/recordingTune.dart';
import 'package:thesession/main.dart';
import 'package:thesession/pages/Tunes/tune_info_page.dart';
import '../../models/tunes/newTune.dart';
import '../../widgets/explore/recording_tune.dart';

class RecordingTunesPage extends StatefulWidget {
  const RecordingTunesPage({Key? key}) : super(key: key);

  @override
  State<RecordingTunesPage> createState() => _RecordingTunesPageState();
}

class _RecordingTunesPageState extends State<RecordingTunesPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  bool _isFirstLoadRunning = false;
  int _pageNum = 1;
  late int _totalPages;

  List<Recording> _recordings = [];

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
        'https://thesession.org/tunes/recordings?format=json&perpage=20&page=${_pageNum}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = recordingTuneDataFromJson(response.body);
      if (!isRefresh) {
        _recordings.addAll(result.tunes);
      } else {
        _recordings = result.tunes;
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
              final recording = _recordings[index];
              return GestureDetector(
                onTap: () => _navigateToPost(context, index),
                child: RecordingTuneCard(
                  recording: recording,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  height: 1,
                ),
            itemCount: _recordings.length),
      ),
    );
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    var item = _recordings[indexOfItem];
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
