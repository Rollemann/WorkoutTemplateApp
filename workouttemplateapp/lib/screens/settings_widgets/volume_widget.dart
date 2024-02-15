import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/settings_caption_widget.dart';

class VolumeWidget extends ConsumerStatefulWidget {
  const VolumeWidget({super.key});

  @override
  ConsumerState<VolumeWidget> createState() => _VolumeWidgetState();
}

class _VolumeWidgetState extends ConsumerState<VolumeWidget> {
  @override
  Widget build(BuildContext context) {
    final volume = ref.watch(volumeProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingsCaptionWidget(
            title: AppLocalizations.of(context)!.settingTitleVolume,
            explanation: "Beschreibung, was die Einstellung macht.",
          ),
        ),
        Row(
          children: [
            IconButton(
              tooltip: "Mute",
              onPressed: () {
                ref.read(volumeProvider.notifier).state = 0;
              },
              icon: const Icon(Icons.volume_off),
            ),
            Expanded(
              child: Slider(
                value: volume,
                max: 100,
                divisions: 10,
                onChanged: (value) {
                  ref.read(volumeProvider.notifier).state = value;
                },
                label: volume.round().toString(),
              ),
            ),
            IconButton(
              tooltip: "Max",
              onPressed: () {
                setState(() {
                  volume <= 90
                      ? ref.read(volumeProvider.notifier).state = volume + 10
                      : ref.read(volumeProvider.notifier).state = 100;
                });
              },
              icon: const Icon(Icons.volume_up),
            ),
          ],
        ),
      ],
    );
  }
}
