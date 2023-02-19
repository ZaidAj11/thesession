import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/pages/event_info_page.dart';
import 'package:thesession/widgets/community/event_display_card.dart';
import '../../models/community/newEvent.dart';
import '../../models/community/newSession.dart';
import '../../widgets/community/session_display_card.dart';
import '../session_info_page.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({super.key});

  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  bool _isFirstLoadRunning = false;
  int _pageNum = 1;
  late int _totalPages;

  List<Event> newEvents = [];

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
        'https://thesession.org/events/new?format=json&perpage=20&page=${_pageNum}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = newEventFromJson(response.body);
      if (!isRefresh) {
        newEvents.addAll(result.events);
      } else {
        newEvents = result.events;
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
            final event = newEvents[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _navigateToPost(context, index);
                },
                child: EventCard(event: event, address: "Test"),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 1,
              ),
          itemCount: newEvents.length),
    );
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    var item = newEvents[indexOfItem];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventInfoPage(title: item.venue.name),
      ),
    );
  }
}
