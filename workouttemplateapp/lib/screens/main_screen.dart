import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/screens/main_widgets/template_details.dart';
import 'package:workouttemplateapp/screens/main_widgets/templates_navigation.dart';
import 'package:workouttemplateapp/screens/settings_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<PlanItemData> plans = ref.watch(planProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: DefaultTabController(
        length: plans.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Test",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
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
