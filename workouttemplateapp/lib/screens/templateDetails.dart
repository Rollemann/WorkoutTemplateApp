import 'package:flutter/material.dart';
import 'package:workouttemplateapp/screens/templateRow.dart';

class TemplateDetails extends StatelessWidget {
  const TemplateDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TemplateRow(),
        TemplateRow(),
      ],
    );
  }
}
