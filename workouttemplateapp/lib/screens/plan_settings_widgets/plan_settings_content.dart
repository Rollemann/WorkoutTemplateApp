import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/screens/plan_settings_widgets/plan_settings_row.dart';
import 'package:workouttemplateapp/template_data_models.dart';

class PlanSettingsContent extends ConsumerStatefulWidget {
  const PlanSettingsContent({super.key});

  @override
  ConsumerState<PlanSettingsContent> createState() => _PlanSettingsListState();
}

class _PlanSettingsListState extends ConsumerState<PlanSettingsContent> {
  final List<bool> checkedPlans = [];

  @override
  Widget build(BuildContext context) {
    final List<PlanItemData> plans = ref.watch(planProvider);
    return Column(
      children: [
        Text(
          "Reorder, rename and share plans here.",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Expanded(
          child: ReorderableListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index) {
              checkedPlans.add(false);
              return PlanSettingsRow(
                key: ObjectKey(plans[index]),
                title: plans[index].name,
                index: index,
                checked: checkedPlans[index],
                onCheck: (bool? checked) => onCheck(index, checked),
              );
            },
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
                  onPressed: allCheckedIndex().length == 1
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
                  child: const Icon(Icons.edit),
                ),
                ElevatedButton(
                  onPressed: allCheckedIndex().isNotEmpty
                      ? () {
                          AllDialogs.showDeleteDialog(
                              context,
                              "Tab ${plans[0].name}",
                              () => {removePlans(allCheckedIndex(), ref)});
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

  List<int> allCheckedIndex() {
    final List<int> indexList = [];
    for (var i = 0; i < checkedPlans.length; i++) {
      if (checkedPlans[i]) {
        indexList.add(i);
      }
    }
    return indexList;
  }

  removePlans(List<int> indexList, WidgetRef ref) {
    for (var i = indexList.length - 1; i >= 0; i--) {
      ref.read(planProvider.notifier).removePlan(i);
    }
  }

  onCheck(int index, bool? checked) {
    setState(() {
      checkedPlans[index] = checked ?? !checkedPlans[index];
    });
  }
}
