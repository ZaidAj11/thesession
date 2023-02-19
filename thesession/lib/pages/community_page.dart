import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thesession/pages/api_results_pages/session_new_page.dart';
import 'package:thesession/widgets/side_drawer.dart';

import '../widgets/my_appbar.dart';
import 'api_results_pages/events_new_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(
          userName: user?.email,
        ),
        appBar: MyAppBar(
          dropdown: Text("Community"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CommunitySection(
                  view: NewSessionPage(),
                  title: "New Sessions",
                ),
                SizedBox(
                  height: 20,
                ),
                CommunitySection(
                  view: NewEventPage(),
                  title: "New Events",
                ),
                CommunitySection(
                  view: NewSessionPage(),
                  title: "New Trips",
                ),
              ],
            ),
          ),
        ));
  }
}

class CommunitySection extends StatelessWidget {
  final view;
  final title;
  const CommunitySection({super.key, required this.view, required this.title});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 0, 0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Divider(
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: Container(
            decoration: BoxDecoration(),
            height: 90,
            child: view,
          ),
        )
      ],
    );
  }
}
