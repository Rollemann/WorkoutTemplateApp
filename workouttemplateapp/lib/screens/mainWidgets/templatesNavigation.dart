import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:workouttemplateapp/dbHandler.dart';

class TemplatesNavigation extends StatelessWidget {
  final Function addTab;
  const TemplatesNavigation({super.key, required this.addTab});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: TabBar(
            tabs: createTabs(),
          ),
        ),
        ElevatedButton(
          onPressed: () => {addTab()},
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder())),
          child: const Icon(Icons.add),
        ),
        ElevatedButton(
          onPressed: () => {log("expend view")},
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder())),
          child: const Icon(Icons.arrow_downward),
        ),
      ],
    );
  }

  List<Tab> createTabs() {
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
