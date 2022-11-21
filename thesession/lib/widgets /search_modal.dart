import 'package:flutter/material.dart';

class SearchModal extends StatefulWidget {
  final TextEditingController textFieldController;
  const SearchModal({Key? key, required this.textFieldController})
      : super(key: key);

  @override
  State<SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textFieldController,
      autocorrect: true,
    );
  }
}
