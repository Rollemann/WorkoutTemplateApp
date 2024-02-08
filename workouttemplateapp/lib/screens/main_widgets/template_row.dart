import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/all_dialogs.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/plan_provider.dart';
import 'package:workouttemplateapp/providers/settings_provider.dart';
import 'package:workouttemplateapp/screens/main_widgets/row_edit_controls.dart';
import 'package:workouttemplateapp/screens/settings_widgets/deletion_type_widget.dart';

class TemplateRow extends ConsumerStatefulWidget {
  final int tabID;
  final int rowID;

  const TemplateRow({
    super.key,
    required this.tabID,
    required this.rowID,
    //required this.animation,
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
    final RowItemData curRowData = plans[widget.tabID].rows[widget.rowID];
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            rowChecked = !rowChecked;
          });
        },
        child: Container(
          color: rowChecked
              ? const Color.fromARGB(255, 0, 145, 5)
              : Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  // Start drag handler
                  Icons.drag_handle,
                ),
                if (editMode && curRowData.type == 0) //EDIT REPS
                  Flexible(
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
                                    controller:
                                        TextEditingController(text: tempWeight),
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
                                    controller:
                                        TextEditingController(text: tempReps),
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
                                controller:
                                    TextEditingController(text: tempExercise),
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
                if (editMode && curRowData.type == 1) //EDIT TIME
                  Flexible(
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
                                    controller:
                                        TextEditingController(text: tempWeight),
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
                                      tempMinutes =
                                          intValue < 999 ? intValue : 999;
                                    } else {
                                      tempMinutes = 0;
                                    }
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(":",
                                    textScaler: TextScaler.linear(2.0)),
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
                                      tempSeconds =
                                          intValue < 60 ? intValue : 0;
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
                if (editMode && curRowData.type == 2) //EDIT PAUSE
                  Flexible(
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
                                      tempMinutes =
                                          intValue < 999 ? intValue : 999;
                                    } else {
                                      tempMinutes = 0;
                                    }
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(":",
                                    textScaler: TextScaler.linear(2.0)),
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
                                      tempSeconds =
                                          intValue < 60 ? intValue : 0;
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
                if (!editMode && curRowData.type == 0) //VIEW REPS
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              curRowData.set == "" ? "-" : curRowData.set,
                              textScaler: const TextScaler.linear(2.5),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  curRowData.exercise == ""
                                      ? "Exercise"
                                      : curRowData.exercise,
                                  textScaler: const TextScaler.linear(1.3),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 8, 8, 1),
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
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
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                if (!editMode && curRowData.type == 1) //VIEW TIME
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: () {
                        AllDialogs.showCountdownDialog(
                          context,
                          curRowData.exercise,
                          timer,
                          events,
                          curRowData.seconds,
                        );
                        startTimer(plans);
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                curRowData.set == "" ? "-" : curRowData.set,
                                textScaler: const TextScaler.linear(2.5),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    curRowData.exercise == ""
                                        ? "Exercise"
                                        : curRowData.exercise,
                                    textScaler: const TextScaler.linear(1.3),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 8, 8, 1),
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
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 8, 8, 0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.fitness_center),
                                          Text(
                                            curRowData.weight,
                                            textScaler:
                                                const TextScaler.linear(1.2),
                                          ),
                                        ],
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
                if (!editMode && curRowData.type == 2) //VIEW PAUSE
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: () {
                        AllDialogs.showCountdownDialog(
                          context,
                          "Pause",
                          timer,
                          events,
                          curRowData.seconds,
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
                          ),
                        ),
                      ),
                    ),
                  ),
                editMode
                    ? RowEditControls(
                        saveAction: () => saveEdits(curRowData),
                        cancelAction: () => cancelEdits(),
                        deleteAction: () =>
                            deleteRow(deletionType, curRowData.exercise))
                    : ElevatedButton(
                        onPressed: () {
                          openEdits(curRowData);
                        },
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(CircleBorder()),
                        ),
                        child: const Icon(Icons.edit),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
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

  void deleteRow(DeletionTypes deletionType, String exercise) {
    if (deletionType == DeletionTypes.always) {
      AllDialogs.showDeleteDialog(
        context,
        "Row $exercise",
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
}

/////////////////////////Drag Lines
/* import 'dart:ui';

class ReorderableApp extends StatelessWidget {
  const ReorderableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ReorderableListView Sample')),
        body: const ReorderableExample(),
      ),
    );
  }
}

class ReorderableExample extends StatefulWidget {
  const ReorderableExample({super.key});

  @override
  State<ReorderableExample> createState() => _ReorderableExampleState();
}

class _ReorderableExampleState extends State<ReorderableExample> {
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);
    final Color draggableItemColor = colorScheme.secondary;

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      children: <Widget>[
        for (int index = 0; index < _items.length; index += 1)
          ListTile(
            key: Key('$index'),
            tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
            title: Text('Item ${_items[index]}'),
            trailing: ReorderableDragStartListener(
              key: ValueKey<int>(_items[index]),
              index: index,
              child: const Icon(Icons.drag_handle),
            ),
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
  }
} */