import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workouttemplateapp/screens/settings_widgets/deletion_type_widget.dart';
import 'package:workouttemplateapp/screens/settings_widgets/language_widget.dart';
import 'package:workouttemplateapp/screens/settings_widgets/light_mode_widget.dart';
import 'package:workouttemplateapp/screens/settings_widgets/show_hints_Widget.dart';
import 'package:workouttemplateapp/screens/settings_widgets/vibration_widget.dart';
import 'package:workouttemplateapp/screens/settings_widgets/volume_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final Widget settingsDivider = const Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Divider(
      indent: 50,
      endIndent: 50,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const VolumeWidget(),
              settingsDivider,
              const VibrationWidget(),
              settingsDivider,
              const ShowHintsWidget(),
              settingsDivider,
              const DeletionTypeWidget(),
              settingsDivider,
              const LightModeWidget(),
              settingsDivider,
              const LanguageWidget(),
              settingsDivider,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Dono"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
