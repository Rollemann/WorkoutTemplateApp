import 'package:flutter/material.dart';
import 'package:workouttemplateapp/providers/sharedPreferenceProvider.dart';
//import 'package:great_list_view/great_list_view.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateRow.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateSettings.dart';

final List<String> rowTypes = ["Reps", "Time", "Pause"];

class TemplateDetails extends StatefulWidget {
  final VoidCallback removeTab;
  final int id;
  final Function renameTab;
  const TemplateDetails({
    super.key,
    required this.removeTab,
    required this.id,
    required this.renameTab,
  });

  @override
  State<TemplateDetails> createState() => _TemplateDetailsState();
}

class _TemplateDetailsState extends State<TemplateDetails> {
  //final controller = AnimatedListController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ReorderableListView.builder(
            itemCount: AllData.allData[widget.id].rows.length,
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
              key: ObjectKey(AllData.allData[widget.id].rows[index]),
              tabID: widget.id,
              rowID: index,
              removeRow: () => removeRow(index),
            ),
            //animation: animation,
          ),
        ),
        TemplateSettings(
          removeTab: widget.removeTab,
          addRow: addRow,
          renameTab: widget.renameTab,
          currentTabId: widget.id,
        ),
      ],
    );
  }

  void addRow(int rowType) {
    setState(() {
      AllData.allData[widget.id].rows.add(RowItemData(type: rowType));
    });
  }

  void removeRow(int index) {
    //final removedRow = templateRows[index];
    setState(() {
      AllData.allData[widget.id].rows.removeAt(index);
    });
  }
}
