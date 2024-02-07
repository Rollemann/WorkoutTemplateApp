import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/settings_widgets/deletion_type_widget.dart';
import 'package:workouttemplateapp/screens/settings_widgets/light_mode_widget.dart';
import 'package:workouttemplateapp/screens/settings_widgets/show_hints_Widget.dart';
import 'package:workouttemplateapp/screens/settings_widgets/vibration_widget.dart';
import 'package:workouttemplateapp/screens/settings_widgets/volume_widget.dart';

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
              const VolumeWidget(),
              settingsDivider,
              const VibrationWidget(),
              settingsDivider,
              const LightModeWidget(),
              settingsDivider,
              const ShowHintsWidget(),
              settingsDivider,
              const DeletionTypeWidget(),
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
