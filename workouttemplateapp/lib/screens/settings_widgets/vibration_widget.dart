import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/settings_caption_widget.dart';

class VibrationWidget extends ConsumerStatefulWidget {
  const VibrationWidget({super.key});

  @override
  ConsumerState<VibrationWidget> createState() => _VibrationWidgetState();
}

class _VibrationWidgetState extends ConsumerState<VibrationWidget> {
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
    final bool vibration = ref.watch(vibrationProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingsCaptionWidget(
            title: AppLocalizations.of(context)!.settingTitleVibration,
            explanation: "Beschreibung, was die Einstellung macht.",
          ),
        ),
        Switch(
          thumbIcon: thumbIconVibration,
          value: vibration,
          onChanged: (bool value) {
            ref.read(vibrationProvider.notifier).state = value;
          },
        ),
      ],
    );
  }
}
