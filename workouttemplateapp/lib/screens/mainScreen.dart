import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/templateDetails.dart';
import 'package:workouttemplateapp/screens/templatesNavigation.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Tab> allTabs = [
    const Tab(
      text: 'Plan 1',
      icon: Icon(Icons.fitness_center),
    ),
    const Tab(
      text: 'Plan 2',
      icon: Icon(Icons.fitness_center),
    ),
    const Tab(
      text: 'Plan 3',
      icon: Icon(Icons.fitness_center),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: allTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Test"),
        ),
        body: Column(
          children: [
            TemplatesNavigation(allTabs: allTabs),
            Expanded(
              child: TabBarView(
                children: [
                  TemplateDetails(),
                  TemplateDetails(),
                  TemplateDetails(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
