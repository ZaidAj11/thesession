import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/pages/api_results_pages/tune_info_page.dart';
import 'package:thesession/pages/session_info_page.dart';
import 'package:thesession/widgets%20/community/session_display_card.dart';
import '../../models/community/newSession.dart';

class NewSessionPage extends StatefulWidget {
  const NewSessionPage({Key? key}) : super(key: key);

  @override
  State<NewSessionPage> createState() => _NewSessionPageState();
}

class _NewSessionPageState extends State<NewSessionPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  bool _isFirstLoadRunning = false;
  int _pageNum = 1;
  late int _totalPages;

  List<Session> newSessions = [];

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
        'https://thesession.org/sessions/new?format=json&perpage=20&page=${_pageNum}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = newSessionsFromJson(response.body);
      if (!isRefresh) {
        newSessions.addAll(result.sessions);
      } else {
        newSessions = result.sessions;
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
    return SmartRefresher(
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
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final session = newSessions[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _navigateToPost(context, index);
                },
                child: SessionCard(session: session, address: "Test"),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 1,
              ),
          itemCount: newSessions.length),
    );
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    var item = newSessions[indexOfItem];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SessionInfoPage(title: item.venue.name),
      ),
    );
  }
}
