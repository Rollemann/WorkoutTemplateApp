import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/plan_settings_widgets/plan_settings_content.dart';

class PlanSettingsScreen extends StatelessWidget {
  const PlanSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: const PlanSettingsContent(),
    );
  }
}
