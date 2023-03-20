import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesession/pages/data_analytics/data_analytics_page.dart';
import 'package:thesession/pages/likes_page.dart';
import 'package:thesession/pages/set_generator_page.dart';
import 'package:thesession/widgets/profile_icon.dart';

class SideDrawer extends StatelessWidget {
  final userName;
  const SideDrawer({Key? key, required this.userName}) : super(key: key);

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: IntrinsicHeight(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Column(
                          children: <Widget>[
                            // Name
                            ProfileIcon(
                              username: userName,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Center(child: Text(userName)),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            DrawerItem(
                              doSomething: () => _navigateToDataPage(context),
                              content: 'Data Analytics',
                              trailingIcon: Icon(Icons.auto_graph),
                            ),
                            Divider(
                              thickness: 0.5,
                            ),
                            DrawerItem(
                              doSomething: () =>
                                  _navigateToSetGeneratorPage(context),
                              content: 'Set Generator',
                              trailingIcon: Icon(Icons.collections),
                            ),
                            Divider(
                              thickness: 0.5,
                            ),
                            DrawerItem(
                              doSomething: () => _navigateToLikesPage(context),
                              content: 'My Likes',
                              trailingIcon: Icon(Icons.favorite),
                            ),
                            Divider(
                              thickness: 0.5,
                            ),
                            DrawerItem(
                              doSomething: () => _navigateToDataPage(context),
                              content: 'My Bookmarks',
                              trailingIcon: Icon(Icons.bookmark),
                            ),
                            Divider(
                              thickness: 0.5,
                            ),
                          ],
                        ),
                        Expanded(
                          child: DrawerItem(
                            doSomething: signOut,
                            content: 'Sign out',
                            trailingIcon: Icon(Icons.exit_to_app),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToDataPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DataAnalyticsPage(),
      ),
    );
  }

  void _navigateToSetGeneratorPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetGeneratorPage(),
      ),
    );
  }

  void _navigateToLikesPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LikesPage(),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final VoidCallback doSomething;
  final String content;
  final Icon trailingIcon;
  const DrawerItem(
      {Key? key,
      required this.doSomething,
      required this.content,
      required this.trailingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: doSomething,
            child: ListTile(
              trailing: trailingIcon,
              title: Text(content),
            ),
          )
        ],
      ),
    );
  }
}
