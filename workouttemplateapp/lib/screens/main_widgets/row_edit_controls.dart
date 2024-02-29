import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RowEditControls extends StatelessWidget {
  final Function saveAction, cancelAction, deleteAction, copyAction;
  const RowEditControls({
    super.key,
    required this.saveAction,
    required this.cancelAction,
    required this.deleteAction,
    required this.copyAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        // End buttons
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {
                saveAction();
              },
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
              ),
              icon: const Icon(Icons.save),
              tooltip: AppLocalizations.of(context)!.save,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {
                cancelAction();
              },
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
              ),
              icon: const Icon(Icons.cancel),
              tooltip: AppLocalizations.of(context)!.cancel,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {
                copyAction();
              },
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
              ),
              icon: const Icon(Icons.copy),
              tooltip: AppLocalizations.of(context)!.duplicate,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {
                deleteAction();
              },
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
              ),
              icon: const Icon(Icons.delete),
              tooltip: AppLocalizations.of(context)!.delete,
            ),
          ),
        ]);
  }
}
