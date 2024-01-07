import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:great_list_view/great_list_view.dart';
import 'package:workouttemplateapp/screens/templateRow.dart';

class TemplateDetails extends StatefulWidget {
  const TemplateDetails({super.key});

  @override
  State<TemplateDetails> createState() => _TemplateDetailsState();
}

class _TemplateDetailsState extends State<TemplateDetails> {
  final listKey = GlobalKey<AnimatedListState>();
  //final controller = AnimatedListController();
  List<String> templateRows = [
    "test1",
    "test2",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ReorderableListView.builder(

          key: listKey,
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
              key: ValueKey(templateRows[index]),
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
    final newIndex = templateRows.length;
    final newRow = "Test $newIndex";
    templateRows.insert(0, newRow);
    log("add");
    //controller.notifyInsertedRange(0, 1);
    listKey.currentState!.insertItem(newIndex);
  }

  void removeRow(int index) {
    final removedRow = templateRows[index];

    templateRows.removeAt(index);
    /* controller.notifyRemovedRange(
        index,
        1,
        (context, index, data) => TemplateRow(
              text: removedRow[index],
              removeRow: () {},
            )); */
    listKey.currentState!.removeItem(
        index,
        (context, animation) => TemplateRow(
              text: removedRow,
              //animation: animation,
              removeRow: () {},
            ));
  }
}
