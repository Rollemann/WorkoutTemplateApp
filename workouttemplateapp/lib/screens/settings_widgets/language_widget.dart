import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/settings_caption_widget.dart';

class LanguageWidget extends ConsumerStatefulWidget {
  const LanguageWidget({super.key});

  @override
  ConsumerState<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends ConsumerState<LanguageWidget> {
  final Map languages = {
    "en": "English",
    "de": "Deutsch",
    "es": "Español",
  };

  @override
  Widget build(BuildContext context) {
    final String language = ref.watch(languageProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingsCaptionWidget(
            title: AppLocalizations.of(context)!.settingTitleLanguage,
            explanation:
                Text(AppLocalizations.of(context)!.settingExplanationLanguage),
          ),
        ),
        DropdownButton(
          value: language,
          icon: Icon(
            Icons.arrow_downward,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
          items: createLanguageItems(),
          onChanged: (value) =>
              ref.read(languageProvider.notifier).state = value,
        ),
      ],
    );
  }

  List<DropdownMenuItem> createLanguageItems() {
    final List<DropdownMenuItem> languageList = [];
    languages.forEach((key, value) {
      languageList.add(DropdownMenuItem(
        value: key,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: CountryFlag.fromLanguageCode(
                key,
                height: 15,
                width: 15,
              ),
            ),
          ],
        ),
      ));
    });
    return languageList;
  }
}
