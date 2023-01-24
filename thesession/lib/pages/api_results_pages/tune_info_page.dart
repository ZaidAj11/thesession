import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/main.dart';
import 'package:thesession/models/tunes/tuneInfo.dart';
import 'package:thesession/widgets%20/tune_display_card.dart';

class TuneInfoPage extends StatefulWidget {
  final String tuneId;
  final String settingId;
  final bool isNewTune;
  const TuneInfoPage(
      {Key? key,
      required this.tuneId,
      required this.settingId,
      required this.isNewTune})
      : super(key: key);

  @override
  State<TuneInfoPage> createState() => _TuneInfoPageState();
}

class _TuneInfoPageState extends State<TuneInfoPage> {
  List<Post> _posts = [];
  String _title = '';
  Future<bool> GetData() async {
    Uri uri = Uri.parse(
        "https://thesession.org/tunes/${widget.tuneId}?format=json${widget.isNewTune ? '#setting' + widget.settingId : ''}");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final TuneInfo result = tuneInfoFromJson(response.body);
      _title = result.name;
      _posts.addAll(result.posts);
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: AppColours.DefaultDarkColour,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final post = _posts[index];
            return TuneCard(
              post: post,
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: _posts.length),
    );
  }
}
