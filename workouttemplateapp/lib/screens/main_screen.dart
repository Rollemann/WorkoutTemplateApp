import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/screens/main_widgets/template_details.dart';
import 'package:workouttemplateapp/screens/main_widgets/templates_navigation.dart';
import 'package:workouttemplateapp/screens/settings_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(planProvider);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: plans.when(
        data: (planData) {
          return DefaultTabController(
            length: planData!.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.plans,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                actions: [
                  IconButton(
                    tooltip: AppLocalizations.of(context)!.settings,
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
                  planData.isNotEmpty
                      ? Expanded(
                          child: TabBarView(
                            children: createTabViews(planData),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 300,
                                child: Text(
                                  AppLocalizations.of(context)!.createFirstPlan,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_upward,
                                size: 35,
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        },
        error: (error, _) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  List<TemplateDetails> createTabViews(List<PlanItemData> plans) {
    final List<TemplateDetails> allTemplateDetails = [];
    for (var i = 0; i < plans.length; i++) {
      allTemplateDetails.add(TemplateDetails(
        planId: plans[i].id,
      ));
    }
    return allTemplateDetails;
  }
}
