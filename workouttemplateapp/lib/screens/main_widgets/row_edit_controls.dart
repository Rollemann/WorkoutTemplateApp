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
            ),
          ),
        ]);
  }
}
