import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lightMode = true;
  bool vibration = true;
  double volume = 0;

  final MaterialStateProperty<Icon?> thumbIconLightDark =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.light_mode);
      }
      return const Icon(Icons.dark_mode);
    },
  );

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("Light/Dark Mode"),
            ),
            Switch(
              thumbIcon: thumbIconLightDark,
              value: lightMode,
              onChanged: (bool value) {
                setState(() {
                  lightMode = value;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text("Vibration"),
            ),
            Switch(
              thumbIcon: thumbIconVibration,
              value: vibration,
              onChanged: (bool value) {
                setState(() {
                  vibration = value;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text("Volume"),
            ),
            Row(
              children: [
                IconButton(
                  tooltip: "Mute",
                  onPressed: () {
                    setState(() {
                      volume = 0;
                    });
                  },
                  icon: const Icon(Icons.volume_off),
                ),
                Expanded(
                  child: Slider(
                    value: volume,
                    max: 100,
                    divisions: 10,
                    onChanged: (value) {
                      setState(() {
                        volume = value;
                      });
                    },
                    label:
                        volume.round().toString(), //volume.round().toString(),
                  ),
                ),
                IconButton(
                  tooltip: "Max",
                  onPressed: () {
                    setState(() {
                      volume = volume <= 90 ? volume + 10 : 100;
                    });
                  },
                  icon: const Icon(Icons.volume_up),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text("Dono"),
            ),
          ],
        ),
      ),
    );
  }
}
