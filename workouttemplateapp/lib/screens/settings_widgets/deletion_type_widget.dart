import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: OutlinedButton(
                  onPressed: () {
                    ref.read(deletionTypeProvider.notifier).state =
                        DeletionTypes.always;
                  },
                  child: Text(
                    AppLocalizations.of(context)!.confirmDeletionAlways,
                    style: (deletionType == DeletionTypes.always)
                        ? const TextStyle(
                            color: Colors.green,
                          )
                        : const TextStyle(),
                  ),
                ),
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ref.read(deletionTypeProvider.notifier).state =
                        DeletionTypes.plans;
                  },
                  child: Text(
                    AppLocalizations.of(context)!.confirmDeletionJustPlans,
                    textAlign: TextAlign.center,
                    style: (deletionType == DeletionTypes.plans)
                        ? const TextStyle(
                            color: Colors.green,
                          )
                        : const TextStyle(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: OutlinedButton(
                  onPressed: () {
                    ref.read(deletionTypeProvider.notifier).state =
                        DeletionTypes.never;
                  },
                  child: Text(
                    AppLocalizations.of(context)!.confirmDeletionNever,
                    style: (deletionType == DeletionTypes.never)
                        ? const TextStyle(
                            color: Colors.green,
                          )
                        : const TextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
