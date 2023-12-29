import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/templateRow.dart';

class TemplateDetails extends StatelessWidget {
  TemplateDetails({super.key});

  final List<TemplateRow> templateRows = [
    const TemplateRow(),
    const TemplateRow(),
    const TemplateRow(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
