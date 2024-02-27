import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/screens/plan_settings_screen.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/main_widgets/template_details.dart';

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
    final plans = ref.watch(planProvider);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MenuAnchor(
            builder: (context, controller, child) {
              return TextButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: const Column(
                  children: [
                    Icon(Icons.add),
                    Text("Add Row"),
                  ],
                ),
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
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanSettingsScreen(
                    currentPlanIndex: currentTabId,
                    planLength: plans.length,
                  ),
                ),
              )
            },
            child: const Column(
              children: [
                Icon(Icons.edit),
                Text("Edit Plan"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addClickHandler(int type, BuildContext context, WidgetRef ref) {
    final bool showHints = ref.read(showHintsProvider);
    final int rowNumber = ref.read(planProvider)[currentTabId].rows.length;
    const int maxRows = 100;

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
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 60),
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
