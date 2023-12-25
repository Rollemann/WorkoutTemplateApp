import 'package:flutter/material.dart';

class TemplateRow extends StatelessWidget {
  const TemplateRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextField(),
        Text("Set"),
        Text("Exercise"),
        Text("Weight"),
        Text("Reps"),
        Text("Button"),
      ],
    );
  }
}
