import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/screens/plan_settings_widgets/plan_settings_row.dart';
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
    return Column(
      children: [
        Text(
          "Reorder, rename, share and delete plans here.",
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
        Container(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: allCheckedIndexes().length == 1
                      ? () {
                          final int index = checkedPlans.indexOf(true);
                          final String title = plans[index].name;
                          AllDialogs.showEditDialog(
                            context,
                            "Rename $title",
                            (String newName) => {
                              ref
                                  .read(planProvider.notifier)
                                  .renamePlan(index, newName)
                            },
                          );
                        }
                      : null,
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder())),
                  child: const Icon(Icons.border_color),
                ),
                const ElevatedButton(
                  onPressed: null,
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder())),
                  child: Icon(Icons.share),
                ),
                ElevatedButton(
                  onPressed: allCheckedIndexes().isNotEmpty
                      ? () {
                          final List<int> allChecked = allCheckedIndexes();
                          final String description = allChecked.length == 1
                              ? "Plan ${plans[allChecked[0]].name}"
                              : "${allChecked.length} Plans";
                          AllDialogs.showDeleteDialog(context, description,
                              () => {removePlans(allCheckedIndexes(), ref)});
                        }
                      : null,
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder())),
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
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
}
