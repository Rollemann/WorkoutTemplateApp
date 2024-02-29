import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
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
                child: Column(
                  children: [
                    const Icon(Icons.add),
                    Text(AppLocalizations.of(context)!.row),
                  ],
                ),
              );
            },
            menuChildren: List<MenuItemButton>.generate(
              rowTypes.length,
              (int index) => MenuItemButton(
                onPressed: () => addNewRow(index, context, ref),
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
            onPressed: () {
              final String title = plans[currentTabId].name;
              AllDialogs.showEditDialog(
                context,
                "Rename $title",
                (String newName) {
                  ref
                      .read(planProvider.notifier)
                      .renamePlan(currentTabId, newName);
                },
              );
            },
            style: TextButton.styleFrom(
              disabledForegroundColor: const Color.fromARGB(255, 150, 150, 150),
            ),
            child: Column(
              children: [
                const Icon(Icons.border_color),
                Text(AppLocalizations.of(context)!.rename),
              ],
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
            child: Column(
              children: [
                const Icon(Icons.edit),
                Text(AppLocalizations.of(context)!.edit),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addNewRow(int type, BuildContext context, WidgetRef ref) {
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
