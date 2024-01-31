import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/settingsProvider.dart';

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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Light/Dark Mode",
            style: TextStyle(fontWeight: FontWeight.bold),
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
