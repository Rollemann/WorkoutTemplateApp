import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/templateRow.dart';

class TemplateDetails extends StatelessWidget {
  TemplateDetails({super.key});

  final List<TemplateRow> templateRows = [
    const TemplateRow(),
    const TemplateRow(),
    const TemplateRow(),
    const TemplateRow(),
    const TemplateRow(),
    const TemplateRow(),
    const TemplateRow(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Set", textScaler: TextScaler.linear(1.2)),
            Text("Exercise", textScaler: TextScaler.linear(1.2)),
            Text("Weight", textScaler: TextScaler.linear(1.2)),
            Text("Reps", textScaler: TextScaler.linear(1.2)),
            Text("", textScaler: TextScaler.linear(1.2)),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: templateRows.length,
            itemBuilder: (BuildContext context, int index) {
              return templateRows[index];
            },
          ),
        ),
      ],
    );
  }
}
