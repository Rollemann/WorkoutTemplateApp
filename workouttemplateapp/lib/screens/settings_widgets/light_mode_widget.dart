import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/settings_caption_widget.dart';

class LightModeWidget extends ConsumerStatefulWidget {
  const LightModeWidget({super.key});

  @override
  ConsumerState<LightModeWidget> createState() => _LightModeWidgetState();
}

class _LightModeWidgetState extends ConsumerState<LightModeWidget> {
  final MaterialStateProperty<Icon?> thumbIconLightDark =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.light_mode);
      }
      return const Icon(Icons.dark_mode);
    },
  );
  @override
  Widget build(BuildContext context) {
    final bool lightMode = ref.watch(lightModeProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingsCaptionWidget(
            title: AppLocalizations.of(context)!.settingTitleLightDarkMode,
            explanation: "Beschreibung, was die Einstellung macht.",
          ),
        ),
        Switch(
          thumbIcon: thumbIconLightDark,
          value: lightMode,
          onChanged: (bool value) {
            ref.read(lightModeProvider.notifier).state = value;
          },
        ),
      ],
    );
  }
}
