import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/models/community/newTrip.dart';
import 'package:thesession/pages/community_pages/trip_info_page.dart';
import 'package:thesession/widgets/community/session_display_card.dart';
import 'package:thesession/widgets/community/trip_display_card.dart';
import '../../models/community/newSession.dart';
import 'session_info_page.dart';

class NewTripsPage extends StatefulWidget {
  const NewTripsPage({super.key});

  @override
  State<NewTripsPage> createState() => _NewTripsPageState();
}

class _NewTripsPageState extends State<NewTripsPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  bool _isFirstLoadRunning = false;
  int _pageNum = 1;
  late int _totalPages;

  List<Trip> newTrips = [];

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
        'https://thesession.org/trips/new?format=json&perpage=20&page=${_pageNum}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = newTripFromJson(response.body);
      if (!isRefresh) {
        newTrips.addAll(result.trips);
      } else {
        newTrips = result.trips;
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
            final event = newTrips[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _navigateToPost(context, index);
                },
                child: TripCard(trip: event),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 1,
              ),
          itemCount: newTrips.length),
    );
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    Trip item = newTrips[indexOfItem];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TripInfoPage(
          trip: item,
        ),
      ),
    );
  }
}
