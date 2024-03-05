import 'package:flutter/material.dart';

class SettingsCaptionWidget extends StatelessWidget {
  final String title;
  final Widget explanation;
  const SettingsCaptionWidget(
      {super.key, required this.title, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Tooltip(
          showDuration: const Duration(seconds: 20),
          triggerMode: TooltipTriggerMode.tap,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10)),
          richMessage: WidgetSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: explanation,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.outlineVariant),
            ),
            child: const Icon(
              Icons.question_mark,
              size: 12,
            ),
          ),
        ),
      ],
    );
  }
}
