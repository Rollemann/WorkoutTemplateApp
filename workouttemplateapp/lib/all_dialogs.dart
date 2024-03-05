import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AllDialogs {
  static showDeleteDialog(
      BuildContext context, String text, Function continueAction) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(AppLocalizations.of(context)!.cancel),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(AppLocalizations.of(context)!.continueT),
      onPressed: () {
        Navigator.of(context).pop();
        continueAction();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.deleteName(text)),
      content: Text(AppLocalizations.of(context)!.deleteNameReally(text)),
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

  static showEditDialog(
      BuildContext context, String title, Function continueAction) {
    String enteredText = "";
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(AppLocalizations.of(context)!.cancel),
      onPressed: () {
        Navigator.of(context).pop();
        enteredText = "";
      },
    );
    Widget continueButton = TextButton(
      child: Text(AppLocalizations.of(context)!.save),
      onPressed: () {
        Navigator.of(context).pop();
        continueAction(enteredText);
        enteredText = "";
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: TextField(
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.newName,
          border: const UnderlineInputBorder(),
        ),
        onChanged: (value) {
          enteredText = value;
        },
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

  static showCountdownDialog(BuildContext context, String title, Timer? timer,
      StreamController<int> events, int initialTime, String? subText) {
    // set up the buttons
    Widget endButton = TextButton(
      child: Text(
        AppLocalizations.of(context)!.continueT,
        textScaler: const TextScaler.linear(1.5),
      ),
      onPressed: () {
        if (timer != null) {
          timer.cancel();
        }
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<int>(
            stream: events.stream,
            builder: (context, snapshot) {
              return Text(
                snapshot.data != null
                    ? "${snapshot.data! < 0 ? "-" : ""}${((snapshot.data!).abs() ~/ 60).toString().padLeft(2, "0")}:${((snapshot.data!).abs() % 60).toString().padLeft(2, "0")}"
                    : "${(initialTime ~/ 60).toString().padLeft(2, "0")}:${(initialTime % 60).toString().padLeft(2, "0")}",
                textAlign: TextAlign.center,
                textScaler: const TextScaler.linear(2.5),
                style: snapshot.data != null && snapshot.data! < 0
                    ? const TextStyle(color: Colors.red)
                    : null,
              );
            },
          ),
          if (subText != null)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                subText,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
        ],
      ),
      actions: [
        endButton,
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
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
