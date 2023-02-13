import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesession/main.dart';
import 'package:thesession/models/tunes/searchResult.dart';
import 'package:http/http.dart' as http;

import 'api_results_pages/tune_info_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  String query = "";
  List<TuneFromSearchResult> searchResults = [];

  Future<bool> GetData() async {
    query = _searchController.text.replaceAll(' ', '%');
    Uri uri = Uri.parse(
        "https://thesession.org/tunes/search?q=${query}?&format=json");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = searchResultTuneFromJson(response.body);
      searchResults.clear();
      searchResults.addAll(result.tunes);
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: MyApp.checkIfDarkModeEnabled(context)
                            ? Colors.grey[900]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (String val) => {GetData()},
                        autofocus: true,
                        controller: _searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: TextStyle(),
                            contentPadding: EdgeInsets.fromLTRB(-5, 0, 0, 10),
                            icon: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Icon(
                                CupertinoIcons.search,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final searchResult = searchResults[index];
                  return GestureDetector(
                    onTap: () {
                      _navigateToPost(context, index);
                    },
                    child: ListTile(
                      title: Text(searchResult.name.toString()),
                      subtitle: Text("By ${searchResult.member.name}"),
                      trailing: Text(searchResult.date.toString()),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: searchResults.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPost(BuildContext context, int indexOfItem) {
    var item = searchResults[indexOfItem];
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
