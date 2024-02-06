import 'package:flutter/material.dart';
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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SettingsCaptionWidget(
            title: "Confirm Deletion",
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
      ],
    );
  }
}
