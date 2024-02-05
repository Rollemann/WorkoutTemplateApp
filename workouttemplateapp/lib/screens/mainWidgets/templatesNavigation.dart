import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/planProvider.dart';

class TemplatesNavigation extends ConsumerWidget {
  const TemplatesNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<PlanItemData> plans = ref.watch(planProvider);
    return Row(
      children: [
        Expanded(
          child: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: createTabs(plans),
          ),
        ),
        ElevatedButton(
          onPressed: () => {
            ref.read(planProvider.notifier).addPlan(
                  PlanItemData(name: "NewTab"),
                )
          },
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder())),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  List<Tab> createTabs(List<PlanItemData> plans) {
    final List<Tab> tabList = [];
    for (var curTab in plans) {
      tabList.add(Tab(
        icon: curTab.icon,
        text: curTab.name,
      ));
    }
    return tabList;
  }
}
