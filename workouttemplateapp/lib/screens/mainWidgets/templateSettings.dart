import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
import 'package:workouttemplateapp/screens/settingsWidgets/deletionTypeWidget.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/planProvider.dart';
import 'package:workouttemplateapp/providers/settingsProvider.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateDetails.dart';

class TemplateSettings extends ConsumerWidget {
  final int currentTabId;
  TemplateSettings({super.key, required this.currentTabId});

  final List<IconData> menuIcons = [
    Icons.replay_outlined,
    Icons.timer_outlined,
    Icons.hourglass_empty_rounded
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    ref
                        .read(planProvider.notifier)
                        .addRow(currentTabId, RowItemData(type: index), null)
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
                  "Rename ${plans[currentTabId].name}",
                  (String newName) => {
                    ref
                        .read(planProvider.notifier)
                        .renamePlan(currentTabId, newName)
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
                      "Tab ${plans[currentTabId].name}",
                      () => {
                            ref
                                .read(planProvider.notifier)
                                .removePlan(currentTabId)
                          });
                } else {
                  ref.read(planProvider.notifier).removePlan(currentTabId);
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
