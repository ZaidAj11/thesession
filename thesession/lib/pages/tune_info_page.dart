import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/main.dart';
import 'package:thesession/models/tunes/tuneInfo.dart';

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
        backgroundColor: AppColours.DefaultColour,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final post = _posts[index];
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PostUi(abc: post.abc, member: post.member),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: _posts.length),
    );
  }
}

class PostUi extends StatelessWidget {
  final abc;
  final Member member;
  const PostUi({Key? key, required this.abc, required this.member})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, //color of border
          width: 2, //width of border
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      abc,
                    ),
                  ),
                  Text("By ${member.name}"),
                ],
              ),
            ),
            VerticalDivider(
              thickness: 2,
              color: Colors.grey[500],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 40,
                ),
                Icon(
                  Icons.bookmark_add_outlined,
                  size: 40,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
