import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/settings_caption_widget.dart';

enum DeletionTypes { always, plans, never }

class DeletionTypeWidget extends ConsumerStatefulWidget {
  const DeletionTypeWidget({super.key});

  @override
  ConsumerState<DeletionTypeWidget> createState() => _DeletionTypeWidgetState();
}

class _DeletionTypeWidgetState extends ConsumerState<DeletionTypeWidget> {
  @override
  Widget build(BuildContext context) {
    final DeletionTypes deletionType = ref.watch(deletionTypeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SettingsCaptionWidget(
              title: AppLocalizations.of(context)!.settingTitleConfirmDeletion,
              explanation: "Beschreibung, was die Einstellung macht.",
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
                  style: (deletionType == DeletionTypes.always)
                      ? const TextStyle(
                          color: Colors.green,
                        )
                      : const TextStyle(),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  ref.read(deletionTypeProvider.notifier).state =
                      DeletionTypes.plans;
                },
                child: Text(
                  "Just Plans",
                  style: (deletionType == DeletionTypes.plans)
                      ? const TextStyle(
                          color: Colors.green,
                        )
                      : const TextStyle(),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  ref.read(deletionTypeProvider.notifier).state =
                      DeletionTypes.never;
                },
                child: Text(
                  "Never",
                  style: (deletionType == DeletionTypes.never)
                      ? const TextStyle(
                          color: Colors.green,
                        )
                      : const TextStyle(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
