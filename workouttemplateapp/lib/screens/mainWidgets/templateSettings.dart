import 'dart:developer';
import 'package:flutter/material.dart';

class TemplateSettings extends StatelessWidget {
  final VoidCallback removeTab;
  const TemplateSettings({super.key, required this.removeTab});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () => {log("expend view")},
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              onPressed: () => {log("expend view")},
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.edit),
            ),
            ElevatedButton(
              onPressed: () => {removeTab()},
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
