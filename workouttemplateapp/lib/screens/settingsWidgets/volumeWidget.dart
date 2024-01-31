import 'package:flutter/material.dart';
import 'package:workouttemplateapp/providers/sharedPreferenceProvider.dart';

class VolumeWidget extends StatefulWidget {
  const VolumeWidget({super.key});

  @override
  State<VolumeWidget> createState() => _VolumeWidgetState();
}

class _VolumeWidgetState extends State<VolumeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }

  void _changeVolume(double value) {
    setState(() {
      SettingsData2.volume = value;
    });
  }
}
