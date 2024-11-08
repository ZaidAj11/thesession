import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesession/widgets/side_drawer.dart';
import '../widgets/my_appbar.dart';
import 'Tunes/tunes_new_page.dart';
import 'Tunes/tunes_popular_page.dart';
import 'Tunes/tunes_recording_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _itemsMap = {
    'New': 0,
    'Popular': 1,
    'Recordings': 2,
  };
  final List<String> _items = ['New', 'Popular', 'Recordings'];
  final _pages = [NewTunesPage(), PopularTunesPage(), RecordingTunesPage()];
  final user = FirebaseAuth.instance.currentUser;

  int selectedIndex = 0;
  bool _isSearching = false;
  StatefulWidget curPage = new NewTunesPage();

  String selectedItem = "New";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        useSearch: true,
        dropdown: DropdownButtonHideUnderline(
          child: DropdownButton2(
            items: _items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            onChanged: (String? val) {
              setState(() {
                selectedItem = val!;
                selectedIndex = _itemsMap[val]!;
              });
            },
            isExpanded: true,
            selectedItemHighlightColor: Colors.grey[400],
            value: selectedItem,
            icon: const Icon(
              CupertinoIcons.chevron_down,
              color: Colors.black,
              size: 20,
            ),
            iconEnabledColor: Colors.yellow,
            iconDisabledColor: Colors.grey,
            buttonHeight: 30,
            buttonWidth: selectedItem == 'New'
                ? 90
                : selectedItem.length.toDouble() * 15,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.grey[200],
            ),
            buttonElevation: 2,
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownWidth: 120,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[200],
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(0, -2),
          ),
        ),
      ),
      drawer: SideDrawer(userName: user?.email),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: IndexedStack(
          index: selectedIndex,
          children: _pages,
        ),
      ),
    );
  }
}
