import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/data/data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';

class PlanNavigation extends ConsumerWidget {
  const PlanNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(planProvider);
    return plans.when(
      data: (planData) => Row(
        children: [
          Expanded(
            child: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              tabs: createPlans(planData!),
            ),
          ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.addPlan,
            onPressed: () => addPlan(ref, planData, context),
            style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder())),
            icon: const Icon(Icons.add, size: 35),
          ),
        ],
      ),
      error: (error, _) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  List<Tab> createPlans(List<PlanItemData> plans) {
    final List<Tab> tabList = [];
    for (var curTab in plans) {
      tabList.add(Tab(
        icon: curTab.icon,
        text: curTab.name,
      ));
    }
    return tabList;
  }

  void addPlan(
      WidgetRef ref, List<PlanItemData> plans, BuildContext context) async {
    final newPlan = PlanItemData(
        name: "NewPlan ${plans.length + 1}", position: plans.length);
    ref.read(planController).addPlan(newPlan);
    ref.invalidate(planProvider);
  }
}
