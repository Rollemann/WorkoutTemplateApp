import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/dataModel.dart';
import 'package:workouttemplateapp/providers/planProvider.dart';
import 'package:workouttemplateapp/providers/settingsProvider.dart';
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
    final List<PlanItemData> plans = ref.watch(planProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          //TODO: AS
          plans;
        });
      },
      child: DefaultTabController(
        length: plans.length,
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
              const TemplatesNavigation(),
              Expanded(
                child: TabBarView(
                  children: createTabViews(plans),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTab() {
    /* setState(() {
      AllData.allData
          .add(PlanItemData(name: "Plan${AllData.allData.length + 1}"));
      log("add new Tab");
    }); */
  }

  void renameTab(String newName, int index) {
    /* setState(() {
      AllData.allData[index].name = newName;
    }); */
  }

  List<TemplateDetails> createTabViews(List<PlanItemData> plans) {
    final List<TemplateDetails> allTemplateDetails = [];
    for (var i = 0; i < plans.length; i++) {
      allTemplateDetails.add(TemplateDetails(
        id: i,
        renameTab: (newName) => renameTab(newName, i),
      ));
    }
    return allTemplateDetails;
  }
}
