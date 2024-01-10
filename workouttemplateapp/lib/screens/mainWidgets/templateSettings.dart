import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:workouttemplateapp/confirmationDialog.dart';

class TemplateSettings extends StatelessWidget {
  final VoidCallback removeTab;
  final Function addRow;
  const TemplateSettings(
      {super.key, required this.removeTab, required this.addRow});

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
              onPressed: () => {log("expend view")},
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.edit),
            ),
            ElevatedButton(
              onPressed: () =>
                  {DeleteDialog.showDeleteDialog(context, "Tab", removeTab)},
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
