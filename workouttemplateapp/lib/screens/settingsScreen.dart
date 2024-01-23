import 'package:flutter/material.dart';
import 'package:workouttemplateapp/dbHandler.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
              value: SettingsData.lightMode,
              onChanged: (bool value) {
                setState(() {
                  SettingsData.lightMode = value;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text("Confirm Deletion"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      SettingsData.deletionType = DeletionConfirmation.always;
                    });
                  },
                  child: Text(
                    "Always",
                    style: TextStyle(
                      color: (SettingsData.deletionType ==
                              DeletionConfirmation.always)
                          ? Colors.green
                          : Colors.black,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      SettingsData.deletionType = DeletionConfirmation.plans;
                    });
                  },
                  child: Text(
                    "Just Plans",
                    style: TextStyle(
                      color: (SettingsData.deletionType ==
                              DeletionConfirmation.plans)
                          ? Colors.green
                          : Colors.black,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      SettingsData.deletionType = DeletionConfirmation.never;
                    });
                  },
                  child: Text(
                    "Never",
                    style: TextStyle(
                      color: (SettingsData.deletionType ==
                              DeletionConfirmation.never)
                          ? Colors.green
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text("Vibration"),
            ),
            Switch(
              thumbIcon: thumbIconVibration,
              value: SettingsData.vibration,
              onChanged: (bool value) {
                setState(() {
                  SettingsData.vibration = value;
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
                      SettingsData.volume = 0;
                    });
                  },
                  icon: const Icon(Icons.volume_off),
                ),
                Expanded(
                  child: Slider(
                    value: SettingsData.volume,
                    max: 100,
                    divisions: 10,
                    onChanged: (value) {
                      setState(() {
                        SettingsData.volume = value;
                      });
                    },
                    label: SettingsData.volume
                        .round()
                        .toString(), //volume.round().toString(),
                  ),
                ),
                IconButton(
                  tooltip: "Max",
                  onPressed: () {
                    setState(() {
                      SettingsData.volume = SettingsData.volume <= 90
                          ? SettingsData.volume + 10
                          : 100;
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
