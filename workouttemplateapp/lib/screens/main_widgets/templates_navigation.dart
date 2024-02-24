import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';

class TemplatesNavigation extends ConsumerWidget {
  const TemplatesNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("message");
    final List<PlanItemData> plans = ref.watch(planProvider);
    return Row(
      children: [
        Expanded(
          child: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: createPlans(plans),
          ),
        ),
        IconButton(
          onPressed: () => addPlan(ref, plans, context),
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder())),
          icon: const Icon(Icons.add, size: 35),
        ),
      ],
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

  void addPlan(WidgetRef ref, List<PlanItemData> plans, BuildContext context) {
    const maxPlans = 25;
    if (plans.length < maxPlans) {
      ref.read(planProvider.notifier).addPlan(
            PlanItemData(name: "NewPlan ${plans.length + 1}"),
          );
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
