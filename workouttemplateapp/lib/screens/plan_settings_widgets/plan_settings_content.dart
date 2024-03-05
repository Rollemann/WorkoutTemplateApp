import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/plan_settings_widgets/plan_settings_row.dart';
import 'package:workouttemplateapp/screens/settings_widgets/deletion_type_widget.dart';
import 'package:workouttemplateapp/template_data_models.dart';

class PlanSettingsContent extends ConsumerStatefulWidget {
  final int currentPlanIndex;
  final int planLength;
  const PlanSettingsContent({
    super.key,
    required this.currentPlanIndex,
    required this.planLength,
  });

  @override
  ConsumerState<PlanSettingsContent> createState() => _PlanSettingsListState();
}

class _PlanSettingsListState extends ConsumerState<PlanSettingsContent> {
  final List<bool> checkedPlans = [];

  @override
  void initState() {
    for (var i = 0; i < widget.planLength; i++) {
      checkedPlans.add(i == widget.currentPlanIndex);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<PlanItemData> plans = ref.watch(planProvider);
    final DeletionTypes deletionType = ref.watch(deletionTypeProvider);
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.planSettingsDescription,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: ReorderableListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index) => PlanSettingsRow(
              key: ObjectKey(plans[index]),
              title: plans[index].name,
              index: index,
              checked: checkedPlans[index],
              onCheck: (bool? checked) => onCheck(index, checked),
            ),
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  --newIndex;
                }
                final plan =
                    ref.read(planProvider.notifier).removePlan(oldIndex);
                ref.read(planProvider.notifier).addPlan(plan, newIndex);
                final bool tempCheck = checkedPlans[oldIndex];
                checkedPlans.removeAt(oldIndex);
                checkedPlans.insert(newIndex, tempCheck);
              });
            },
          ),
        ),
        //Bottom Bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => addPlan(ref, plans, context),
                style: TextButton.styleFrom(
                  disabledForegroundColor:
                      const Color.fromARGB(255, 150, 150, 150),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.add),
                    Text(AppLocalizations.of(context)!.add),
                  ],
                ),
              ),
              TextButton(
                onPressed: null,
                style: TextButton.styleFrom(
                  disabledForegroundColor:
                      const Color.fromARGB(255, 150, 150, 150),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.share),
                    Text(AppLocalizations.of(context)!.share),
                  ],
                ),
              ),
              TextButton(
                onPressed: allCheckedIndexes().isNotEmpty
                    ? () {
                        final List<int> allChecked = allCheckedIndexes();
                        final String description = allChecked.length == 1
                            ? plans[allChecked[0]].name
                            : "${allChecked.length} ${AppLocalizations.of(context)!.plans}";
                        deletionType == DeletionTypes.never
                            ? removePlans(allCheckedIndexes(), ref)
                            : AllDialogs.showDeleteDialog(context, description,
                                () => {removePlans(allCheckedIndexes(), ref)});
                      }
                    : null,
                style: TextButton.styleFrom(
                  disabledForegroundColor:
                      const Color.fromARGB(255, 150, 150, 150),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.delete),
                    Text(AppLocalizations.of(context)!.delete),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<int> allCheckedIndexes() {
    final List<int> indexList = [];
    for (var i = 0; i < checkedPlans.length; i++) {
      if (checkedPlans[i]) {
        indexList.add(i);
      }
    }
    return indexList;
  }

  removePlans(List<int> indexList, WidgetRef ref) {
    indexList.sort();
    for (var i = indexList.length - 1; i >= 0; i--) {
      ref.read(planProvider.notifier).removePlan(indexList[i]);
      checkedPlans.removeAt(indexList[i]);
    }
  }

  onCheck(int index, bool? checked) {
    setState(() {
      checkedPlans[index] = checked ?? !checkedPlans[index];
    });
  }

  void addPlan(WidgetRef ref, List<PlanItemData> plans, BuildContext context) {
    const maxPlans = 25;
    if (plans.length < maxPlans) {
      ref.read(planProvider.notifier).addPlan(
            PlanItemData(name: "NewPlan ${plans.length + 1}"),
          );
      checkedPlans.add(false);
    } else {
      final snackBar = SnackBar(
        content: const Text('Max. $maxPlans plans. Delete one first.',
            textScaler: TextScaler.linear(1.5)),
        action: SnackBarAction(
          backgroundColor: Colors.yellow,
          textColor: Colors.black,
          label: 'X',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
