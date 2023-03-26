import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesession/pages/bookmarked_tunes_page.dart';

import '../widgets/my_appbar.dart';

class BookmarksPage extends StatefulWidget {
  BookmarksPage({super.key});
  final _pages = [BookmarkedTunesPage()];
  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final _itemsMap = {'Tunes': 0, 'Sessions': 0};
  final List<String> _items = ['Tunes', 'Sessions'];

  int selectedIndex = 0;
  bool _isSearching = false;

  String selectedItem = "Tunes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        useSearch: false,
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
            buttonWidth: 300,
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
            dropdownWidth: 300,
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
      body: IndexedStack(
        index: selectedIndex,
        children: widget._pages,
      ),
    );
  }
}
