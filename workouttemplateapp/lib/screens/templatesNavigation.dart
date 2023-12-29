import 'dart:developer';

import 'package:flutter/material.dart';

class TemplatesNavigation extends StatelessWidget {
  final List<Tab> allTabs;

  const TemplatesNavigation({required this.allTabs, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: TabBar(
            tabs: allTabs,
          ),
        ),
        ElevatedButton(
          onPressed: () => {log("new Tab")},
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder())),
          child: const Icon(Icons.add),
        ),
        ElevatedButton(
          onPressed: () => {log("expend view")},
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder())),
          child: const Icon(Icons.arrow_downward),
        )
      ],
    );
  }
}
