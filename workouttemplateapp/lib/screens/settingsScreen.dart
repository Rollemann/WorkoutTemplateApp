import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/dbHandler.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final double dividerIndent = 50;

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
    //final bool lightMode = ref.watch(LightMode.provider);
    final bool lightMode = ref.watch(lightModeProvider);
    final DeletionTypes deletionType = ref.watch(deletionTypeProvider);
    //final SettingsData settings = ref.watch(settingsDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Light/Dark Mode",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Switch(
                thumbIcon: thumbIconLightDark,
                value: lightMode,
                onChanged: (bool value) {
                  ref.read(lightModeProvider.notifier).state = value;
                  //_changeLightMode(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  indent: dividerIndent,
                  endIndent: dividerIndent,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Confirm Deletion",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ref.read(deletionTypeProvider.notifier).state =
                          DeletionTypes.always;
                    },
                    child: Text(
                      "Always",
                      style: TextStyle(
                        color: (deletionType == DeletionTypes.always)
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      ref.read(deletionTypeProvider.notifier).state =
                          DeletionTypes.plans;
                    },
                    child: Text(
                      "Just Plans",
                      style: TextStyle(
                        color: (deletionType == DeletionTypes.plans)
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      ref.read(deletionTypeProvider.notifier).state =
                          DeletionTypes.never;
                    },
                    child: Text(
                      "Never",
                      style: TextStyle(
                        color: (deletionType == DeletionTypes.never)
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  indent: dividerIndent,
                  endIndent: dividerIndent,
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  indent: dividerIndent,
                  endIndent: dividerIndent,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Volume",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: "Mute",
                    onPressed: () {
                      _changeVolume(0);
                    },
                    icon: const Icon(Icons.volume_off),
                  ),
                  Expanded(
                    child: Slider(
                      value: SettingsData2.volume,
                      max: 100,
                      divisions: 10,
                      onChanged: (value) {
                        _changeVolume(value);
                      },
                      label: SettingsData2.volume
                          .round()
                          .toString(), //volume.round().toString(),
                    ),
                  ),
                  IconButton(
                    tooltip: "Max",
                    onPressed: () {
                      setState(() {
                        SettingsData2.volume <= 90
                            ? _changeVolume(SettingsData2.volume + 10)
                            : _changeVolume(100);
                      });
                    },
                    icon: const Icon(Icons.volume_up),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  indent: dividerIndent,
                  endIndent: dividerIndent,
                ),
              ),
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

  void _changeLightMode(bool value) async {}

  void _changeDeletionType(DeletionTypes value) async {}

  void _changeVibration(bool value) {
    setState(() {
      SettingsData2.vibration = value;
    });
  }

  void _changeVolume(double value) {
    setState(() {
      SettingsData2.volume = value;
    });
  }
}
