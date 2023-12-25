import 'package:flutter/material.dart';

class TemplatesNavigation extends StatelessWidget {
  const TemplatesNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("1"),
        Text("2"),
      ],
    );
  }
}
