import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:great_list_view/great_list_view.dart';
import 'package:workouttemplateapp/screens/templateRow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemplateDetails extends StatefulWidget {
  const TemplateDetails({super.key});

  @override
  State<TemplateDetails> createState() => _TemplateDetailsState();
}

class _TemplateDetailsState extends State<TemplateDetails> {
  //final controller = AnimatedListController();
  List<String> templateRows = [
    "test0",
    "test1",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ReorderableListView.builder(
          itemCount: templateRows.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                --newIndex;
              }
              final row = templateRows.removeAt(oldIndex);
              templateRows.insert(newIndex, row);
            });
          },
          itemBuilder: (context, index) => TemplateRow(
              key: ValueKey(index),
              text: templateRows[index],
              //animation: animation,
              removeRow: () => removeRow(index)),
        ),
        FloatingActionButton(
          onPressed: () => addRow(),
          tooltip: 'Add new Row',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  void addRow() {
    setState(() {
      final newIndex = templateRows.length;
      final newRow = "Test $newIndex";
      templateRows.add(newRow);
      log("add ${templateRows.length}");
    });
  }

  void removeRow(int index) {
    setState(() {
      //final removedRow = templateRows[index];
      templateRows.removeAt(index);
    });
  }
}
