import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/dataModel.dart';
import 'package:workouttemplateapp/providers/planProvider.dart';
import 'package:workouttemplateapp/providers/sharedPreferenceProvider.dart';

class TemplatesNavigation extends ConsumerWidget {
  final Function addTab;
  const TemplatesNavigation({super.key, required this.addTab});

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
            addTab()
            /* ref.read(planProvider.notifier).addPlan(
                  PlanItemData(name: "TestnewTab"),
                ) */
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
    for (var curTab in AllData.allData) {
      tabList.add(Tab(
        icon: curTab.icon,
        text: curTab.name,
      ));
    }
    return tabList;
  }
}
