import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
import 'package:workouttemplateapp/screens/plan_settings_screen.dart';
import 'package:workouttemplateapp/data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';

class TemplateSettings extends ConsumerWidget {
  final int planId;
  final List<IconData> menuIcons = const [
    Icons.replay_outlined,
    Icons.timer_outlined,
    Icons.hourglass_empty_rounded
  ];

  const TemplateSettings({
    super.key,
    required this.planId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(planProvider);
    final List<String> rowTypes = [
      AppLocalizations.of(context)!.reps,
      AppLocalizations.of(context)!.time,
      AppLocalizations.of(context)!.pause,
    ];
    return plans.when(
      data: (plansData) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MenuAnchor(
              style: MenuStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.secondaryContainer),
              ),
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
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            menuIcons[index],
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        ),
                        Text(
                          rowTypes[index],
                          textScaler: const TextScaler.linear(2),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final String title = plansData![planId].name;
                AllDialogs.showEditDialog(
                  context,
                  '${AppLocalizations.of(context)!.newNameFor} "$title"',
                  (String newName) async {
                    final plans = await ref.read(planProvider.future);
                    PlanItemData plan = plans![planId];
                    plan.name = newName;
                    ref.read(planController).updatePlan(plan);
                    ref.invalidate(planProvider);
                  },
                );
              },
              style: TextButton.styleFrom(
                disabledForegroundColor:
                    const Color.fromARGB(255, 150, 150, 150),
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
                      currentPlanIndex: planId,
                      planLength: plansData!.length,
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
      ),
      error: (error, _) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void addNewRow(int type, BuildContext context, WidgetRef ref) async {
    final bool showHints = ref.read(showHintsProvider);
    final rows = await ref.read(rowProvider.future);
    final curRows = rows!.where((row) => row.planId == planId).toList();

    ref.read(rowController).addRow(
          RowItemData(
            planId: planId,
            type: type,
            set: (_getNonPauseRowNumber(curRows) + 1).toString(),
          ),
        );
    ref.invalidate(rowProvider);
    if (showHints && type > 0) {
      _showSnackBar(AppLocalizations.of(context)!.startTimerInfo, context);
    }
  }

  void _showSnackBar(String infoText, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(infoText, textScaler: const TextScaler.linear(1.5)),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 60),
      action: SnackBarAction(
        label: 'X',
        backgroundColor: const Color.fromARGB(255, 255, 235, 150),
        textColor: Colors.black,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  int _getNonPauseRowNumber(List<RowItemData> rows) {
    int counter = 0;
    for (var row in rows) {
      if (row.type != 2) counter++;
    }
    return counter;
  }
}
