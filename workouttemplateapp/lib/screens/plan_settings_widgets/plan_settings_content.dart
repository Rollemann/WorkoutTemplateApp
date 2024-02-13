import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return ReorderableListView.builder(
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
          final plan = ref.read(planProvider.notifier).removePlan(oldIndex);
          ref.read(planProvider.notifier).addPlan(plan, newIndex);
          final bool tempCheck = checkedPlans[oldIndex];
          checkedPlans.removeAt(oldIndex);
          checkedPlans.insert(newIndex, tempCheck);
        });
      },
    );
  }

  onCheck(int index, bool? checked) {
    setState(() {
      checkedPlans[index] = checked ?? !checkedPlans[index];
    });
  }
}
