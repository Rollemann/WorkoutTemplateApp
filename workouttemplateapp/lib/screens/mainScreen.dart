import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/planProvider.dart';
import 'package:workouttemplateapp/providers/settingsProvider.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templateDetails.dart';
import 'package:workouttemplateapp/screens/mainWidgets/templatesNavigation.dart';
import 'package:workouttemplateapp/screens/settingsScreen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool lightMode = ref.watch(lightModeProvider);
    final List<PlanItemData> plans = ref.watch(planProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
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

  List<TemplateDetails> createTabViews(List<PlanItemData> plans) {
    final List<TemplateDetails> allTemplateDetails = [];
    for (var i = 0; i < plans.length; i++) {
      allTemplateDetails.add(TemplateDetails(
        id: i,
      ));
    }
    return allTemplateDetails;
  }
}
