import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/allDialogs.dart';
import 'package:workouttemplateapp/dataModel.dart';
import 'package:workouttemplateapp/providers/planProvider.dart';
import 'package:workouttemplateapp/providers/settingsProvider.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateDetails.dart';
import 'package:workouttemplateapp/screens/settingsWidgets/deletionTypeWidget.dart';

class TemplateSettings extends ConsumerStatefulWidget {
  final Function renameTab;
  final int currentTabId;
  const TemplateSettings(
      {super.key, required this.renameTab, required this.currentTabId});

  @override
  ConsumerState<TemplateSettings> createState() => _TemplateSettingsState();
}

class _TemplateSettingsState extends ConsumerState<TemplateSettings> {
  String? selectedRowType;
  List<IconData> menuIcons = [
    Icons.replay_outlined,
    Icons.timer_outlined,
    Icons.hourglass_empty_rounded
  ];

  @override
  Widget build(BuildContext context) {
    final DeletionTypes deletionType = ref.watch(deletionTypeProvider);
    final List<PlanItemData> plans = ref.watch(planProvider);

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
                  onPressed: () => {
                    ref.read(planProvider.notifier).addRow(
                        widget.currentTabId, RowItemData(type: index), null)
                  },
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
                  "Rename ${plans[widget.currentTabId].name}",
                  (String newName) => {
                    ref
                        .read(planProvider.notifier)
                        .renamePlan(widget.currentTabId, newName)
                  },
                )
              },
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.edit),
            ),
            ElevatedButton(
              onPressed: () {
                if (deletionType != DeletionTypes.never) {
                  AllDialogs.showDeleteDialog(
                      context,
                      "Tab ${plans[widget.currentTabId].name}",
                      () => {
                            ref
                                .read(planProvider.notifier)
                                .removePlan(widget.currentTabId)
                          });
                } else {
                  ref
                      .read(planProvider.notifier)
                      .removePlan(widget.currentTabId);
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
