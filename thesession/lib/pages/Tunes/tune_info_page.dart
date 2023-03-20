import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thesession/main.dart';
import 'package:thesession/models/tunes/tuneInfo.dart';
import 'package:thesession/widgets/explore/setting_display_card.dart';

class TuneInfoPage extends StatefulWidget {
  final String tuneId;
  final String settingId;
  final bool isNewTune;
  final List<dynamic>? likedSettings;
  const TuneInfoPage(
      {Key? key,
      required this.tuneId,
      required this.settingId,
      required this.isNewTune,
      this.likedSettings})
      : super(key: key);

  @override
  State<TuneInfoPage> createState() => _TuneInfoPageState();
}

class _TuneInfoPageState extends State<TuneInfoPage> {
  List<Post> _posts = [];
  String _title = '';
  late TuneInfo _tuneInfo;
  Future<bool> GetData() async {
    Uri uri = Uri.parse(
        "https://thesession.org/tunes/${widget.tuneId}?format=json${widget.isNewTune ? '#setting' + widget.settingId : ''}");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final TuneInfo result = tuneInfoFromJson(response.body);
      _tuneInfo = result;
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
            post.tuneInfo = _tuneInfo;
            return TuneCard(
              post: post,
              showFooter: true,
              isLiked: checkIfLiked(post.id),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: _posts.length),
    );
  }

  bool checkIfLiked(int settingId) {
    if (widget.likedSettings != null && widget.likedSettings!.isNotEmpty) {
      if (widget.likedSettings!.contains(settingId)) return true;
      return false;
    }
    return false;
  }
}
