import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
import 'package:workouttemplateapp/app.dart';
import 'package:workouttemplateapp/screens/main_widgets/row_edit_frame.dart';
import 'package:workouttemplateapp/screens/main_widgets/row_view_frame.dart';
import 'package:workouttemplateapp/data/data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/settings_widgets/deletion_type_widget.dart';

class PlanRow extends ConsumerStatefulWidget {
  final int planId;
  final int rowId;

  const PlanRow({
    super.key,
    required this.planId,
    required this.rowId,
  });

  @override
  ConsumerState<PlanRow> createState() => _PlanRowState();
}

class _PlanRowState extends ConsumerState<PlanRow> {
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
    final rows = ref.watch(rowProvider);
    final bool lightMode = ref.watch(lightModeProvider);
    final bool vibrate = ref.watch(vibrationProvider);
    final double volume = ref.watch(volumeProvider);
    final String sound = ref.watch(soundProvider);
    return rows.when(
      data: (rowsData) {
        final planRows =
            rowsData!.where((row) => row.planId == widget.planId).toList();
        final curRowData =
            planRows.where((row) => row.id == widget.rowId).toList()[0];
        if (editMode) {
          if (curRowData.type == 0) {
            //EDIT REPS
            return RowEditFrame(
              saveEdits: () => saveEdits(curRowData),
              cancelEdits: cancelEdits,
              copyAction: () => copyRow(curRowData, planRows),
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
                                  controller:
                                      TextEditingController(text: tempSet),
                                  decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context)!.set,
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
                                controller:
                                    TextEditingController(text: tempWeight),
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.weight,
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
                                controller:
                                    TextEditingController(text: tempReps),
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.reps,
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
                            controller:
                                TextEditingController(text: tempExercise),
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.exercise,
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
            return RowEditFrame(
              saveEdits: () => saveEdits(curRowData),
              cancelEdits: cancelEdits,
              copyAction: () => copyRow(curRowData, planRows),
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
                                  controller:
                                      TextEditingController(text: tempSet),
                                  decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context)!.set,
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
                                controller:
                                    TextEditingController(text: tempWeight),
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.weight,
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
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.min,
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
                            child:
                                Text(":", textScaler: TextScaler.linear(2.0)),
                          ),
                          Flexible(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(
                                  text: (tempSeconds).toString()),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.sec,
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
                            controller:
                                TextEditingController(text: tempExercise),
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.exercise,
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
            return RowEditFrame(
              saveEdits: () => saveEdits(curRowData),
              cancelEdits: cancelEdits,
              copyAction: () => copyRow(curRowData, planRows),
              deleteRow: () => deleteRow(deletionType, curRowData.exercise),
              child: Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.pause,
                        textScaler: const TextScaler.linear(1.5),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(
                                  text: (tempMinutes).toString()),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.min,
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
                            child:
                                Text(":", textScaler: TextScaler.linear(2.0)),
                          ),
                          Flexible(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(
                                  text: (tempSeconds).toString()),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.sec,
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
            return RowViewFrame(
              onEdit: () => openEdits(curRowData),
              rowChecked: rowChecked,
              toggleRowChecked: toggleRowCheck,
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
                                padding: const EdgeInsets.only(
                                    right: 15.0, bottom: 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: lightMode ? onLight : onDark,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.replay_rounded),
                                        Text(
                                          curRowData.reps == ""
                                              ? "0x"
                                              : "${curRowData.reps}x",
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
                                  color: lightMode ? onLight : onDark,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.fitness_center),
                                      Text(
                                        curRowData.weight == ""
                                            ? "0"
                                            : curRowData.weight,
                                        textScaler:
                                            const TextScaler.linear(1.2),
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
            return RowViewFrame(
              onEdit: () => openEdits(curRowData),
              rowChecked: rowChecked,
              toggleRowChecked: toggleRowCheck,
              child: Expanded(
                child: GestureDetector(
                  onDoubleTap: () {
                    AllDialogs.showCountdownDialog(
                      context,
                      curRowData.exercise,
                      timer,
                      events,
                      curRowData.seconds,
                      null,
                      vibrate,
                      volume,
                      closeTimerAction,
                      sound,
                    );
                    startTimer(curRowData);
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
                                  padding: const EdgeInsets.only(
                                      right: 15.0, bottom: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: lightMode ? onLight : onDark,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.timer_outlined),
                                          Text(
                                            secondsToTimeString(
                                                curRowData.seconds),
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
                                    color: lightMode ? onLight : onDark,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 2, 8, 2),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.fitness_center),
                                        Text(
                                          curRowData.weight == ""
                                              ? "0"
                                              : curRowData.weight,
                                          textScaler:
                                              const TextScaler.linear(1.2),
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
            return RowViewFrame(
              onEdit: () => openEdits(curRowData),
              rowChecked: rowChecked,
              toggleRowChecked: toggleRowCheck,
              child: Expanded(
                child: GestureDetector(
                  onDoubleTap: () {
                    AllDialogs.showCountdownDialog(
                      context,
                      AppLocalizations.of(context)!.pause,
                      timer,
                      events,
                      curRowData.seconds,
                      getNextExercise(planRows, curRowData),
                      vibrate,
                      volume,
                      closeTimerAction,
                      sound,
                    );
                    startTimer(curRowData);
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
      },
      error: (error, _) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void saveEdits(RowItemData curRowData) {
    setState(() {
      editMode = !editMode;
    });

    final RowItemData newRow = RowItemData(
      id: curRowData.id,
      planId: curRowData.planId,
      set: tempSet,
      weight: tempWeight,
      type: curRowData.type,
      reps: tempReps,
      exercise: tempExercise,
      seconds: (tempMinutes * 60) + (tempSeconds % 60),
      position: curRowData.position,
    );
    ref.read(rowController).updateRow(newRow);
    ref.invalidate(rowProvider);
    resetEditFields();
  }

  void cancelEdits() {
    setState(() {
      editMode = !editMode;
    });
    resetEditFields();
  }

  void copyRow(RowItemData curRowData, List<RowItemData> rows) {
    setState(() {
      editMode = !editMode;
    });
    final RowItemData newRow = RowItemData(
      planId: curRowData.id,
      set: (_getNonPauseRowNumber(rows) + 1).toString(),
      weight: tempWeight,
      type: curRowData.type,
      reps: tempReps,
      exercise: tempExercise,
      seconds: (tempMinutes * 60) + (tempSeconds % 60),
      position: rows.length,
    );
    ref.read(rowController).addRow(newRow);
    ref.invalidate(rowProvider);
    resetEditFields();
  }

  void deleteRow(DeletionTypes deletionType, String exercise) {
    if (deletionType == DeletionTypes.always) {
      AllDialogs.showDeleteDialog(
        context,
        "${AppLocalizations.of(context)!.row} $exercise",
        () {
          ref.read(rowController).deleteRow(widget.rowId);
          ref.invalidate(rowProvider);
        },
      );
    } else {
      ref.read(rowController).deleteRow(widget.rowId);
      ref.invalidate(rowProvider);
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

  void startTimer(RowItemData row) {
    if (timer != null) {
      timer!.cancel();
    }
    curSeconds = row.seconds;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      events.add(--curSeconds);
    });
  }

  void closeTimerAction(Timer? timer) {
    if (timer != null) {
      timer.cancel();
    }
    toggleRowCheck();
  }

  bool toggleRowCheck() {
    setState(() {
      rowChecked = !rowChecked;
    });
    return rowChecked;
  }

  String secondsToTimeString(int sec) {
    return "${(sec ~/ 60).toString().padLeft(2, "0")}:${(sec % 60).toString().padLeft(2, "0")}";
  }

  String? getNextExercise(List<RowItemData> planRows, RowItemData curRow) {
    if (curRow.position == planRows.length - 1) {
      return null;
    }

    RowItemData nextRowData = planRows
        .where((row) => row.position == curRow.position + 1)
        .toList()[0];
    return "${AppLocalizations.of(context)!.next}: ${nextRowData.exercise}";
  }

  int _getNonPauseRowNumber(List<RowItemData> rows) {
    int counter = 0;
    for (var row in rows) {
      if (row.type != 2) counter++;
    }
    return counter;
  }
}
