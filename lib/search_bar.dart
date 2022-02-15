import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:input_history_text_field/input_history_text_field.dart';

class SearchBar extends StatefulWidget {
  final void Function(String value) onSubmitted;

  const SearchBar({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: InputHistoryTextField(
              historyKey: 'search-course',
              onSubmitted: widget.onSubmitted,
              decoration: const InputDecoration(
                hintText: '  Search anything',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
