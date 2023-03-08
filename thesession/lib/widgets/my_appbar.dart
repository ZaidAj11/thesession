import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/search_page.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  const MyAppBar({Key? key, required this.dropdown, required this.useSearch})
      : super(key: key);
  final Widget dropdown;
  final bool useSearch;
  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey[850],
            height: 1,
          ),
          preferredSize: Size.fromHeight(4.0)),
      elevation: 0,
      titleSpacing: 0,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.dropdown,
          if (widget.useSearch)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: GestureDetector(
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchPage()))
                      },
                  child: Icon(CupertinoIcons.search)),
            ),
        ],
      ),
    );
  }
}
