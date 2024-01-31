import 'package:flutter/material.dart';
import 'package:workouttemplateapp/providers/sharedPreferenceProvider.dart';

class VibrationWidget extends StatefulWidget {
  const VibrationWidget({super.key});

  @override
  State<VibrationWidget> createState() => _VibrationWidgetState();
}

class _VibrationWidgetState extends State<VibrationWidget> {
  final MaterialStateProperty<Icon?> thumbIconVibration =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.vibration);
      }
      return const Icon(Icons.not_interested);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Vibration",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Switch(
          thumbIcon: thumbIconVibration,
          value: SettingsData2.vibration,
          onChanged: (bool value) {
            _changeVibration(value);
          },
        ),
      ],
    );
  }

  void _changeVibration(bool value) {
    setState(() {
      SettingsData2.vibration = value;
    });
  }
}
