import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/settings_caption_widget.dart';

class ShowHintsWidget extends ConsumerStatefulWidget {
  const ShowHintsWidget({super.key});

  @override
  ConsumerState<ShowHintsWidget> createState() => _ShowHintWidgetState();
}

class _ShowHintWidgetState extends ConsumerState<ShowHintsWidget> {
  final MaterialStateProperty<Icon?> thumbIconLightDark =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.info_outline);
      }
      return const Icon(Icons.not_interested);
    },
  );
  @override
  Widget build(BuildContext context) {
    final bool showHints = ref.watch(showHintsProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingsCaptionWidget(
            title: AppLocalizations.of(context)!.settingTitleShowHints,
            explanation:
                Text(AppLocalizations.of(context)!.settingExplanationShowHints),
          ),
        ),
        Switch(
          thumbIcon: thumbIconLightDark,
          value: showHints,
          onChanged: (bool value) {
            ref.read(showHintsProvider.notifier).state = value;
          },
        ),
      ],
    );
  }
}
