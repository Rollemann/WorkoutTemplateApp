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
    return ListTile(
      leading: const Icon(Icons.drag_handle),
      title: Text(title),
      trailing: Checkbox(value: checked, onChanged: onCheck),
      //todo: tileColor on checked
    );
  }
}
