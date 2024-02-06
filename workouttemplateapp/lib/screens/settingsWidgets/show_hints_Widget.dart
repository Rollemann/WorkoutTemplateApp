import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settingsProvider.dart';

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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Show hints when creating a Row",
            style: TextStyle(fontWeight: FontWeight.bold),
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
