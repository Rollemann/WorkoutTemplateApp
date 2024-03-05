import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
import 'package:workouttemplateapp/app.dart';
import 'package:workouttemplateapp/screens/main_widgets/template_row_edit_frame.dart';
import 'package:workouttemplateapp/screens/main_widgets/template_row_view_frame.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/deletion_type_widget.dart';

class TemplateRow extends ConsumerStatefulWidget {
  final int tabID;
  final int rowID;

  const TemplateRow({
    super.key,
    required this.tabID,
    required this.rowID,
  });

  @override
  ConsumerState<TemplateRow> createState() => _TemplateRowState();
}

class _TemplateRowState extends ConsumerState<TemplateRow> {
  Timer? timer;
  StreamController<int> events = StreamController<int>.broadcast();
  late int curSeconds = 0;

  bool rowChecked = false;
  bool editMode = false;
  String tempSet = "";
  String tempWeight = "";
  String tempReps = "";
  String tempExercise = "";
  int tempMinutes = 0;
  int tempSeconds = 0;

  @override
  void initState() {
    events.add(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DeletionTypes deletionType = ref.watch(deletionTypeProvider);
    final List<PlanItemData> plans = ref.watch(planProvider);
    final bool lightMode = ref.watch(lightModeProvider);
    final RowItemData curRowData = plans[widget.tabID].rows[widget.rowID];
    if (editMode) {
      if (curRowData.type == 0) {
        //EDIT REPS
        return TemplateRowEditFrame(
          rowID: widget.rowID,
          saveEdits: () => saveEdits(curRowData),
          cancelEdits: cancelEdits,
          copyAction: () => copyRow(curRowData),
          deleteRow: () => deleteRow(deletionType, curRowData.exercise),
          child: Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 30.0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(text: tempSet),
                              decoration: const InputDecoration(
                                labelText: 'Set',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (text) {
                                tempSet = text;
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: TextEditingController(text: tempWeight),
                            decoration: const InputDecoration(
                              labelText: 'Weight',
                            ),
                            onChanged: (text) {
                              tempWeight = text;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(text: tempReps),
                            decoration: const InputDecoration(
                              labelText: 'Reps',
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (text) {
                              tempReps = text;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: TextEditingController(text: tempExercise),
                        decoration: const InputDecoration(
                          labelText: 'Exercise',
                        ),
                        onChanged: (text) {
                          tempExercise = text;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      if (curRowData.type == 1) {
        //EDIT TIME
        return TemplateRowEditFrame(
          rowID: widget.rowID,
          saveEdits: () => saveEdits(curRowData),
          cancelEdits: cancelEdits,
          copyAction: () => copyRow(curRowData),
          deleteRow: () => deleteRow(deletionType, curRowData.exercise),
          child: Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 30.0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(text: tempSet),
                              decoration: const InputDecoration(
                                labelText: 'Set',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (text) {
                                tempSet = text;
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: TextEditingController(text: tempWeight),
                            decoration: const InputDecoration(
                              labelText: 'Weight',
                            ),
                            onChanged: (text) {
                              tempWeight = text;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: TextEditingController(
                              text: (tempMinutes).toString()),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: 'Min',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (value != "") {
                              int intValue = int.parse(value);
                              tempMinutes = intValue < 999 ? intValue : 999;
                            } else {
                              tempMinutes = 0;
                            }
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(":", textScaler: TextScaler.linear(2.0)),
                      ),
                      Flexible(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: TextEditingController(
                              text: (tempSeconds).toString()),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: 'Sec',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (value != "") {
                              int intValue = int.parse(value);
                              tempSeconds = intValue < 60 ? intValue : 0;
                            } else {
                              tempSeconds = 0;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: TextEditingController(text: tempExercise),
                        decoration: const InputDecoration(
                          labelText: 'Exercise',
                        ),
                        onChanged: (text) {
                          tempExercise = text;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      if (curRowData.type == 2) {
        //EDIT PAUSE
        return TemplateRowEditFrame(
          rowID: widget.rowID,
          saveEdits: () => saveEdits(curRowData),
          cancelEdits: cancelEdits,
          copyAction: () => copyRow(curRowData),
          deleteRow: () => deleteRow(deletionType, curRowData.exercise),
          child: Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pause:",
                    textScaler: TextScaler.linear(1.5),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: TextEditingController(
                              text: (tempMinutes).toString()),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: 'Min',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (value != "") {
                              int intValue = int.parse(value);
                              tempMinutes = intValue < 999 ? intValue : 999;
                            } else {
                              tempMinutes = 0;
                            }
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(":", textScaler: TextScaler.linear(2.0)),
                      ),
                      Flexible(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: TextEditingController(
                              text: (tempSeconds).toString()),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: 'Sec',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (value != "") {
                              int intValue = int.parse(value);
                              tempSeconds = intValue < 60 ? intValue : 0;
                            } else {
                              tempSeconds = 0;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } else {
      if (curRowData.type == 0) {
        //VIEW REPS
        return TemplateRowViewFrame(
          onEdit: () => openEdits(curRowData),
          rowID: widget.rowID,
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
                    child: Text(
                      curRowData.set == "" ? "-" : curRowData.set,
                      textScaler: const TextScaler.linear(2.5),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 8),
                        child: Text(
                          curRowData.exercise == ""
                              ? AppLocalizations.of(context)!.exercise
                              : curRowData.exercise,
                          textScaler: const TextScaler.linear(1.5),
                          style: const TextStyle(letterSpacing: 1.2),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, bottom: 2),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: lightMode
                                    ? widget.rowID % 2 == 0
                                        ? onEvenLight
                                        : onOddLight
                                    : widget.rowID % 2 == 0
                                        ? onEvenDark
                                        : onOddDark,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                child: Row(
                                  children: [
                                    const Icon(Icons.replay_rounded),
                                    Text(
                                      curRowData.reps == ""
                                          ? "0x"
                                          : "${curRowData.reps}x",
                                      textScaler: const TextScaler.linear(1.2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: lightMode
                                  ? widget.rowID % 2 == 0
                                      ? onEvenLight
                                      : onOddLight
                                  : widget.rowID % 2 == 0
                                      ? onEvenDark
                                      : onOddDark,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                              child: Row(
                                children: [
                                  const Icon(Icons.fitness_center),
                                  Text(
                                    curRowData.weight == ""
                                        ? "0"
                                        : curRowData.weight,
                                    textScaler: const TextScaler.linear(1.2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
      if (curRowData.type == 1) {
        //VIEW TIME
        return TemplateRowViewFrame(
          onEdit: () => openEdits(curRowData),
          rowID: widget.rowID,
          child: Expanded(
            child: GestureDetector(
              onDoubleTap: () {
                AllDialogs.showCountdownDialog(context, curRowData.exercise,
                    timer, events, curRowData.seconds, null);
                startTimer(plans);
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
                      child: Text(
                        curRowData.set == "" ? "-" : curRowData.set,
                        textScaler: const TextScaler.linear(2.5),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 8),
                          child: Text(
                            curRowData.exercise == ""
                                ? AppLocalizations.of(context)!.exercise
                                : curRowData.exercise,
                            textScaler: const TextScaler.linear(1.5),
                            style: const TextStyle(letterSpacing: 1.2),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, bottom: 2),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: lightMode
                                      ? widget.rowID % 2 == 0
                                          ? onEvenLight
                                          : onOddLight
                                      : widget.rowID % 2 == 0
                                          ? onEvenDark
                                          : onOddDark,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.timer_outlined),
                                      Text(
                                        secondsToTimeString(curRowData.seconds),
                                        textScaler:
                                            const TextScaler.linear(1.2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: lightMode
                                    ? widget.rowID % 2 == 0
                                        ? onEvenLight
                                        : onOddLight
                                    : widget.rowID % 2 == 0
                                        ? onEvenDark
                                        : onOddDark,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                child: Row(
                                  children: [
                                    const Icon(Icons.fitness_center),
                                    Text(
                                      curRowData.weight,
                                      textScaler: const TextScaler.linear(1.2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      if (curRowData.type == 2) {
        //VIEW PAUSE
        return TemplateRowViewFrame(
          onEdit: () => openEdits(curRowData),
          rowID: widget.rowID,
          child: Expanded(
            child: GestureDetector(
              onDoubleTap: () {
                AllDialogs.showCountdownDialog(
                  context,
                  "Pause",
                  timer,
                  events,
                  curRowData.seconds,
                  getNextExercise(plans[widget.tabID].rows),
                );
                startTimer(plans);
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Pause: ${secondsToTimeString(curRowData.seconds)}",
                    textScaler: const TextScaler.linear(1.5),
                    style: const TextStyle(letterSpacing: 1.2),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
    return const Placeholder();
  }

  void saveEdits(RowItemData curRowData) {
    setState(() {
      editMode = !editMode;
    });

    final RowItemData newRow = RowItemData(
      set: tempSet,
      weight: tempWeight,
      type: curRowData.type,
      reps: tempReps,
      exercise: tempExercise,
      seconds: (tempMinutes * 60) + (tempSeconds % 60),
    );
    ref.read(planProvider.notifier).editRow(widget.tabID, newRow, widget.rowID);
    resetEditFields();
  }

  void cancelEdits() {
    setState(() {
      editMode = !editMode;
    });
    resetEditFields();
  }

  void copyRow(RowItemData curRowData) {
    setState(() {
      editMode = !editMode;
    });
    final RowItemData newRow = RowItemData(
      set: tempSet,
      weight: tempWeight,
      type: curRowData.type,
      reps: tempReps,
      exercise: tempExercise,
      seconds: (tempMinutes * 60) + (tempSeconds % 60),
    );
    ref.read(planProvider.notifier).addRow(widget.tabID, newRow);
    resetEditFields();
  }

  void deleteRow(DeletionTypes deletionType, String exercise) {
    if (deletionType == DeletionTypes.always) {
      AllDialogs.showDeleteDialog(
        context,
        "${AppLocalizations.of(context)!.row} $exercise",
        () => ref
            .read(planProvider.notifier)
            .removeRow(widget.tabID, widget.rowID),
      );
    } else {
      ref.read(planProvider.notifier).removeRow(widget.tabID, widget.rowID);
    }
  }

  void openEdits(RowItemData curRowData) {
    setState(() {
      editMode = !editMode;
    });
    tempSet = curRowData.set;
    tempWeight = curRowData.weight;
    tempReps = curRowData.reps;
    tempExercise = curRowData.exercise;
    tempMinutes = curRowData.seconds ~/ 60;
    tempSeconds = curRowData.seconds % 60;
  }

  void resetEditFields() {
    tempSet = "";
    tempWeight = "";
    tempReps = "";
    tempExercise = "";
    tempMinutes = 0;
    tempSeconds = 0;
  }

  void startTimer(List<PlanItemData> plans) {
    if (timer != null) {
      timer!.cancel();
    }
    curSeconds = plans[widget.tabID].rows[widget.rowID].seconds;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      events.add(--curSeconds);
    });
  }

  String secondsToTimeString(int sec) {
    return "${(sec ~/ 60).toString().padLeft(2, "0")}:${(sec % 60).toString().padLeft(2, "0")}";
  }

  String? getNextExercise(List<RowItemData> rows) {
    if (widget.rowID == rows.length - 1) {
      return null;
    }
    RowItemData nextRowData = rows[widget.rowID + 1];
    return "${AppLocalizations.of(context)!.next}: ${nextRowData.exercise}";
  }
}
