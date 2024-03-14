import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/settings_caption_widget.dart';

class SoundWidget extends ConsumerStatefulWidget {
  const SoundWidget({super.key});

  @override
  ConsumerState<SoundWidget> createState() => _SoundWidgetState();
}

class _SoundWidgetState extends ConsumerState<SoundWidget> {
  final List<String> sounds = const [
    "ring01.mp3",
    "ring02.mp3",
    "ring03.mp3",
  ];

  @override
  Widget build(BuildContext context) {
    final String sound = ref.watch(soundProvider);
    final double volume = ref.watch(volumeProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingsCaptionWidget(
            title: AppLocalizations.of(context)!.settingTitleSound,
            explanation:
                Text(AppLocalizations.of(context)!.settingExplanationSound),
          ),
        ),
        DropdownButton(
          value: sound,
          icon: Icon(
            Icons.arrow_downward,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
          items: createSoundItems(context, volume),
          onChanged: (value) => ref.read(soundProvider.notifier).state = value,
        ),
      ],
    );
  }

  List<DropdownMenuItem> createSoundItems(context, volume) {
    final List<DropdownMenuItem> languageList = [];
    for (var i = 0; i < sounds.length; i++) {
      String value = sounds[i];
      languageList.add(DropdownMenuItem(
        value: value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.music_note),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text("${AppLocalizations.of(context)!.sound} ${i + 1}"),
            ),
          ],
        ),
        onTap: () => startSound(volume, value),
      ));
    }
    return languageList;
  }

  Future<void> startSound(double volume, String sound) async {
    final player = AudioPlayer();
    await player.setVolume(volume / 100);
    await player.play(AssetSource(sound));
  }
}
