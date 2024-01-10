import 'package:flutter/material.dart';

class AllDialogs {
  static showDeleteDialog(
      BuildContext context, String text, Function continueAction) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
        continueAction();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete $text"),
      content: Text("Really delete the $text?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showEditDialog(BuildContext context, String text,
      Function continueAction, int currentTabId) {
    String enteredText = "";
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
        enteredText = "";
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Edit"),
      onPressed: () {
        Navigator.of(context).pop();
        continueAction(enteredText, currentTabId);
        enteredText = "";
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit $text"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Enter the new Name for the Tab: "),
          TextField(
            decoration: const InputDecoration(
              labelText: 'New Tab Name',
              border: UnderlineInputBorder(),
            ),
            onChanged: (value) {
              enteredText = value;
            },
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
