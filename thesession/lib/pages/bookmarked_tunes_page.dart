import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/tunes/tuneInfo.dart';
import '../utils/firestoreService.dart';
import '../widgets/explore/tune_info_card.dart';
import 'Tunes/tune_info_page.dart';

class BookmarkedTunesPage extends StatefulWidget {
  const BookmarkedTunesPage({super.key});

  @override
  State<BookmarkedTunesPage> createState() => _BookmarkedTunesPageState();
}

class _BookmarkedTunesPageState extends State<BookmarkedTunesPage> {
  List<TuneInfo> bookmarkedTunes = [];
  late Map<String, dynamic> bookmarkedTunesMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (bookmarkedTunes.isEmpty)
                return Text('You have not bookmarked any tunes yet...');
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final tuneInfo = bookmarkedTunes[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () => _navigateToPost(context, index),
                          child: TuneInfoCard(tuneInfo: tuneInfo)),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                  ),
                  itemCount: bookmarkedTunes.length,
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        )
      ],
    );
  }

  Future<bool> _getData() async {
    bool hasData = await FireStoreService.getBookmarkedTunes();
    if (!hasData) return false;
    if (bookmarkedTunes.isNotEmpty) bookmarkedTunes.clear();
    bookmarkedTunesMap = FireStoreService.BookmarkedTunesMap;
    for (var tuneId in bookmarkedTunesMap.keys) {
      var uri = Uri.parse('https://thesession.org/tunes/${tuneId}?format=json');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final TuneInfo tuneInfo = tuneInfoFromJson(response.body);
        bookmarkedTunes.add(tuneInfo);
      }
    }
    return true;
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    var item = bookmarkedTunes[indexOfItem];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TuneInfoPage(
          tuneId: item.id.toString(),
          settingId: '',
          isNewTune: false,
          likedSettings: bookmarkedTunesMap[item.id.toString()],
        ),
      ),
    );
  }
}
