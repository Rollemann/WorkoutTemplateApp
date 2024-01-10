import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:workouttemplateapp/dbHandler.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateDetails.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templatesNavigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AllData.allData.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Test"),
        ),
        body: Column(
          children: [
            TemplatesNavigation(
              addTab: addTab,
            ),
            Expanded(
              child: TabBarView(
                children: createTabViews(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTab() {
    setState(() {
      AllData.allData.add(PlanItemData("Plan${AllData.allData.length}"));
      log("add new Tab");
    });
  }

  void removeTab(int index) {
    setState(() {
      AllData.allData.removeAt(index);
    });
  }

  List<TemplateDetails> createTabViews() {
    final List<TemplateDetails> allTemplateDetails = [];
    for (var i = 0; i < AllData.allData.length; i++) {
      PlanItemData tab = AllData.allData[i];
      allTemplateDetails.add(TemplateDetails(
        id: i,
        removeTab: () => removeTab(i),
      ));
    }
    return allTemplateDetails;
  }
}
