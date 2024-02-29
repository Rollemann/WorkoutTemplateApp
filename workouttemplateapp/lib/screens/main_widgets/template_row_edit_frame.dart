import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/app.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/main_widgets/row_edit_controls.dart';

class TemplateRowEditFrame extends ConsumerWidget {
  final Widget child;
  final int rowID;
  final Function saveEdits;
  final Function cancelEdits;
  final Function deleteRow;
  final Function copyAction;

  const TemplateRowEditFrame({
    super.key,
    required this.child,
    required this.rowID,
    required this.saveEdits,
    required this.cancelEdits,
    required this.deleteRow,
    required this.copyAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightMode = ref.watch(lightModeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Container(
        color: lightMode
            ? rowID % 2 == 0
                ? evenLight
                : oddLight
            : rowID % 2 == 0
                ? evenDark
                : oddDark,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.drag_handle,
              ),
              child,
              RowEditControls(
                saveAction: () => saveEdits(),
                cancelAction: () => cancelEdits(),
                deleteAction: () => deleteRow(),
                copyAction: () => copyAction(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
