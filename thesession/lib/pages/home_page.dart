// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:thesession/main.dart';
import 'package:thesession/pages/community_page.dart';
import 'package:thesession/pages/explore_page.dart';
import 'package:thesession/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  final List<Widget> _pages = [
    ExplorePage(),
    CommunityPage(),
    ProfilePage(),
  ];
  final List<String> _titles = [
    "Explore",
    "Community",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColours.DefaultColour,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
        ],
      ),
    );
  }
}
