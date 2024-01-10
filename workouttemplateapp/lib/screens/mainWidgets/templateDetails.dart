import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:workouttemplateapp/dbHandler.dart';
//import 'package:great_list_view/great_list_view.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateRow.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateSettings.dart';

class TemplateDetails extends StatefulWidget {
  final VoidCallback removeTab;
  final int id;
  TemplateDetails({super.key, required this.removeTab, required this.id}) {}

  @override
  State<TemplateDetails> createState() => _TemplateDetailsState();
}

class _TemplateDetailsState extends State<TemplateDetails> {
  late List<RowItemData> templateRows = AllData.allData[widget.id].rows;
  //final controller = AnimatedListController();

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
              final row = AllData.allData[widget.id].rows.removeAt(oldIndex);
              AllData.allData[widget.id].rows.insert(newIndex, row);
            });
          },
          itemBuilder: (context, index) => TemplateRow(
              key: ValueKey(index),
              tabID: widget.id,
              rowID: index,
              removeRow: () => removeRow(index)),
          //animation: animation,
        ),
        TemplateSettings(
          removeTab: widget.removeTab,
          addRow: addRow,
        ),
      ],
    );
  }

  void addRow() {
    final newIndex = templateRows.length;
    final newRow = "Test $newIndex";
    setState(() {
      AllData.allData[widget.id].rows.add(RowItemData());
    });
    log("add ${templateRows.length}");
  }

  void removeRow(int index) {
    log("Index: $index");
    log("Länge: ${AllData.allData[widget.id].rows.length}");
    setState(() {
      //final removedRow = templateRows[index];
      AllData.allData[widget.id].rows.removeAt(index);
    });
  }
}
