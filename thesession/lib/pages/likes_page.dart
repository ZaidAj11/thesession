import 'package:flutter/material.dart';
import 'package:thesession/models/tunes/tuneInfo.dart';
import 'package:thesession/utils/firestoreService.dart';
import 'package:http/http.dart' as http;

import '../widgets/explore/tune_info_card.dart';
import 'Tunes/tune_info_page.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({super.key});

  @override
  State<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  List<TuneInfo> likedTunes = [];
  late Map<String, dynamic> likesMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Likes'),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (likedTunes.isEmpty)
                  return Text('You have not liked anything yet...');
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final tuneInfo = likedTunes[index];
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
                    itemCount: likedTunes.length,
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }

  Future<bool> _getData() async {
    bool hasData = await FireStoreService.getLikedTunes();
    if (!hasData) return false;
    if (likedTunes.isNotEmpty) likedTunes.clear();
    likesMap = FireStoreService.LikesMap;
    for (var tuneId in likesMap.keys) {
      var uri = Uri.parse('https://thesession.org/tunes/${tuneId}?format=json');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final TuneInfo tuneInfo = tuneInfoFromJson(response.body);
        likedTunes.add(tuneInfo);
      }
    }
    return true;
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    var item = likedTunes[indexOfItem];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TuneInfoPage(
          tuneId: item.id.toString(),
          settingId: '',
          isNewTune: false,
          likedSettings: likesMap[item.id.toString()],
        ),
      ),
    );
  }
}
