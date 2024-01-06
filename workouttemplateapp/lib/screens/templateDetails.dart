import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/templateRow.dart';

class TemplateDetails extends StatefulWidget {
  const TemplateDetails({super.key});

  @override
  State<TemplateDetails> createState() => _TemplateDetailsState();
}

class _TemplateDetailsState extends State<TemplateDetails> {
  final listKey = GlobalKey<AnimatedListState>();
  List<String> templateRows = [
    "test1",
    "test2",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => {addRow(0)},
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder())),
          child: const Icon(Icons.add),
        ),
        Expanded(
          child: AnimatedList(
            key: listKey,
            initialItemCount: templateRows.length,
            itemBuilder: (context, index, animation) => TemplateRow(
                text: templateRows[index],
                animation: animation,
                addRow: () => addRow(index),
                removeRow: () => removeRow(index)),
          ),
        ),
      ],
    );
  }

  void addRow(int index) {
    final newIndex = index+1; 
    final newRow = "Test $newIndex";
    templateRows.insert(newIndex, newRow);
    listKey.currentState!.insertItem(newIndex);
  }

  void removeRow(int index) {
    final removedRow = templateRows[index];

    templateRows.removeAt(index);

    listKey.currentState!.removeItem(
        index,
        (context, animation) => TemplateRow(
              text: removedRow,
              animation: animation,
              addRow: () {},
              removeRow: () {},
            ));
  }
}
