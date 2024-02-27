import 'package:flutter/material.dart';

class PlanSettingsRow extends StatelessWidget {
  final String title;
  final int index;
  final bool checked;
  final void Function(bool?) onCheck;
  const PlanSettingsRow({
    super.key,
    required this.title,
    required this.index,
    required this.checked,
    required this.onCheck,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCheck(!checked),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListTile(
          leading: const Icon(Icons.drag_handle),
          title: Text(title),
          trailing: Checkbox(value: checked, onChanged: onCheck),
          tileColor: checked
              ? const Color.fromARGB(255, 223, 167, 0)
              : Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
