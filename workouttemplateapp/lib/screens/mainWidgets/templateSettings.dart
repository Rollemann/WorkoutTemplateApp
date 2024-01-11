import 'package:flutter/material.dart';
import 'package:workouttemplateapp/allDialogs.dart';
import 'package:workouttemplateapp/dbHandler.dart';

class TemplateSettings extends StatelessWidget {
  final VoidCallback removeTab;
  final Function addRow;
  final Function renameTab;
  final int currentTabId;
  const TemplateSettings(
      {super.key,
      required this.removeTab,
      required this.addRow,
      required this.renameTab,
      required this.currentTabId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () => {addRow()},
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              onPressed: () => {
                AllDialogs.showEditDialog(
                  context,
                  "Rename ${AllData.allData[currentTabId].name}",
                  renameTab,
                )
              },
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.edit),
            ),
            ElevatedButton(
              onPressed: () => {
                AllDialogs.showDeleteDialog(
                  context,
                  "Tab ${AllData.allData[currentTabId].name}",
                  removeTab,
                )
              },
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
