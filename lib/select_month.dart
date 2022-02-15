import 'package:dashboard_fun/compare_with_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectMonth extends StatelessWidget {
  CompareWith selected;
  void Function(CompareWith value) onSelectChanged;

  SelectMonth({
    Key? key,
    required this.selected,
    required this.onSelectChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Compare with'),
        DropdownButton<CompareWith>(
          value: selected,
          items: const [
            DropdownMenuItem(
              child: Text('Last month'),
              value: CompareWith.lastMonth,
            ),
            DropdownMenuItem(
              child: Text('Last year'),
              value: CompareWith.lastYear,
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              onSelectChanged(value);
            }
          },
        ),
      ],
    );
  }
}
