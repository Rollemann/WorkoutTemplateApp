import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsCaptionWidget extends StatelessWidget {
  final String title;
  final String explanation;
  const SettingsCaptionWidget(
      {super.key, required this.title, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Tooltip(
          showDuration: const Duration(seconds: 30),
          triggerMode: TooltipTriggerMode.tap,
          message: explanation,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    width: 1,
                    color: Theme.of(context).textTheme.titleSmall!.color!)),
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
