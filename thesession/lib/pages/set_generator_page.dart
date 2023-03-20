import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/models/tunes/tuneInfo.dart';
import 'package:thesession/widgets/explore/popular_tune_card.dart';
import 'package:thesession/widgets/explore/setting_display_card.dart';
import 'package:thesession/widgets/explore/tune_info_card.dart';
import '../main.dart';
import 'Tunes/tune_info_page.dart';

class SetGeneratorPage extends StatefulWidget {
  const SetGeneratorPage({super.key});

  @override
  State<SetGeneratorPage> createState() => _SetGeneratorPageState();
}

class _SetGeneratorPageState extends State<SetGeneratorPage> {
  bool _isGenerating = false;
  List<TuneInfo> tunes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Generator'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Divider(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: () => {
                setState(() => _isGenerating = true),
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Generate Set",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 20),
          if (_isGenerating)
            FutureBuilder(
              future: _generateSet(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final tune = tunes[index];
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TuneInfoCard(tuneInfo: tune),
                          ),
                          onTap: () {
                            _navigateToPost(context, index);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                      ),
                      itemCount: tunes.length,
                    ),
                  );
                } else {
                  return Container(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator());
                }
              },
            )
          else
            Text('Nothing here...'),
        ],
      ),
    );
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    var item = tunes[indexOfItem];
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

  Future<bool> _generateSet() async {
    if (tunes.isNotEmpty) tunes.clear();
    for (int i = 0; i < 3; i++) {
      var uri = Uri.parse(
          'https://thesession.org/tunes/${Random().nextInt(9999)}?format=json');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final TuneInfo tuneInfo = tuneInfoFromJson(response.body);
        tunes.add(tuneInfo);
      }
    }
    if (tunes.isNotEmpty) {
      _isGenerating = false;
      return true;
    }
    return false;
  }
}
