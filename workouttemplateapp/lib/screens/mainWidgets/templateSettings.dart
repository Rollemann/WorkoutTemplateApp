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
  final List<IconData> menuIcons = const [
    Icons.replay_outlined,
    Icons.timer_outlined,
    Icons.hourglass_empty_rounded
  ];

  const TemplateSettings({super.key, required this.currentTabId});

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
                  onPressed: () => addClickHandler(index, context, ref),
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

  void addClickHandler(int type, BuildContext context, WidgetRef ref) {
    final bool showHints = ref.read(showHintsProvider);
    final int rowNumber = ref.read(planProvider)[currentTabId].rows.length;
    const int maxRows = 50;

    if (rowNumber < maxRows) {
      ref
          .read(planProvider.notifier)
          .addRow(currentTabId, RowItemData(type: type));
    } else {
      _showSnackBar("Reached limit of $maxRows rows.", context);
      return;
    }
    if (showHints && type > 0) {
      _showSnackBar("Double click the row to start the timer!", context);
    }
  }

  void _showSnackBar(String infoText, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(infoText, textScaler: const TextScaler.linear(1.5)),
      action: SnackBarAction(
        label: 'X',
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
