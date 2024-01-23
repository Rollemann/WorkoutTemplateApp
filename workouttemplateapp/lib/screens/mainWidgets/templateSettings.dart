import 'package:flutter/material.dart';
import 'package:workouttemplateapp/allDialogs.dart';
import 'package:workouttemplateapp/dbHandler.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateDetails.dart';

class TemplateSettings extends StatefulWidget {
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
  State<TemplateSettings> createState() => _TemplateSettingsState();
}

class _TemplateSettingsState extends State<TemplateSettings> {
  String? selectedRowType;
  List<IconData> menuIcons = [
    Icons.replay_outlined,
    Icons.timer_outlined,
    Icons.hourglass_empty_rounded
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MenuAnchor(
              builder: (context, controller, child) {
                return ElevatedButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder())),
                  child: const Icon(Icons.add),
                );
              },
              menuChildren: List<MenuItemButton>.generate(
                rowTypes.length,
                (int index) => MenuItemButton(
                  onPressed: () => setState(() => widget.addRow(index)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(menuIcons[index]),
                        Text(rowTypes[index],
                            textScaler: const TextScaler.linear(2)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => {
                AllDialogs.showEditDialog(
                  context,
                  "Rename ${AllData.allData[widget.currentTabId].name}",
                  widget.renameTab,
                )
              },
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.edit),
            ),
            ElevatedButton(
              onPressed: () {
                if (SettingsData.deletionType != DeletionConfirmation.never) {
                  AllDialogs.showDeleteDialog(
                    context,
                    "Tab ${AllData.allData[widget.currentTabId].name}",
                    widget.removeTab,
                  );
                } else {
                  widget.removeTab();
                }
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
