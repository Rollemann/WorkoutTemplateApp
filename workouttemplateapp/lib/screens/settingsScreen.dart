import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/settingsWidgets/deletionTypeWidget.dart';
import 'package:workouttemplateapp/screens/settingsWidgets/lightModeWidget.dart';
import 'package:workouttemplateapp/screens/settingsWidgets/show_hints_Widget.dart';
import 'package:workouttemplateapp/screens/settingsWidgets/vibrationWidget.dart';
import 'package:workouttemplateapp/screens/settingsWidgets/volumeWidget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final Widget settingsDivider = const Padding(
    padding: EdgeInsets.symmetric(vertical: 10.0),
    child: Divider(
      indent: 50,
      endIndent: 50,
    ),
  );

  @override
  Widget build(BuildContext context) {
    //final bool lightMode = ref.watch(lightModeProvider);
    //final DeletionTypes deletionType = ref.watch(deletionTypeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const LightModeWidget(),
              settingsDivider,
              const DeletionTypeWidget(),
              settingsDivider,
              const VibrationWidget(),
              settingsDivider,
              const VolumeWidget(),
              settingsDivider,
              const ShowHintsWidget(),
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
