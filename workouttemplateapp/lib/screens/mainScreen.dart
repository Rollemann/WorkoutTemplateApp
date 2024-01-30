import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/dbHandler.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateDetails.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templatesNavigation.dart';
import 'package:workouttemplateapp/screens/settingsScreen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool lightMode = ref.watch(lightModeProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          //TODO: AS
          AllData.allData;
        });
      },
      child: DefaultTabController(
        length: AllData.allData.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: lightMode ? Colors.amber : Colors.brown,
            title: const Text("Test"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                },
                icon: const Icon(Icons.settings),
              )
            ],
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
      ),
    );
  }

  void addTab() {
    setState(() {
      AllData.allData.add(PlanItemData("Plan${AllData.allData.length + 1}"));
      log("add new Tab");
    });
  }

  void removeTab(int index) {
    setState(() {
      AllData.allData.removeAt(index);
    });
  }

  void renameTab(String newName, int index) {
    setState(() {
      AllData.allData[index].name = newName;
    });
  }

  List<TemplateDetails> createTabViews() {
    final List<TemplateDetails> allTemplateDetails = [];
    for (var i = 0; i < AllData.allData.length; i++) {
      allTemplateDetails.add(TemplateDetails(
        id: i,
        removeTab: () => removeTab(i),
        renameTab: (newName) => renameTab(newName, i),
      ));
    }
    return allTemplateDetails;
  }
}
