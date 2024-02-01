import 'package:flutter/material.dart';

class RowEditControls extends StatelessWidget {
  final Function saveAction, cancelAction, deleteAction;
  const RowEditControls(
      {super.key,
      required this.saveAction,
      required this.cancelAction,
      required this.deleteAction});

  @override
  Widget build(BuildContext context) {
    return Column(
        // End buttons
        children: [
          ElevatedButton(
            onPressed: () {
              saveAction();
            },
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder()),
            ),
            child: const Icon(Icons.save),
          ),
          ElevatedButton(
            onPressed: () {
              cancelAction();
            },
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder()),
            ),
            child: const Icon(Icons.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              deleteAction();
            },
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder()),
            ),
            child: const Icon(Icons.delete),
          ),
        ]);
  }
}
