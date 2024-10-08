import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workouttemplateapp/screens/plan_settings_widgets/plan_settings_content.dart';

class PlanSettingsScreen extends StatelessWidget {
  final int planPosition;
  final int plansLength;
  const PlanSettingsScreen({
    super.key,
    required this.planPosition,
    required this.plansLength,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.planSettings,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: PlanSettingsContent(
        planPosition: planPosition,
        plansLength: plansLength,
      ),
    );
  }
}
