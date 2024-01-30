import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/allDialogs.dart';
import 'package:workouttemplateapp/dbHandler.dart';

class TemplateRow extends ConsumerStatefulWidget {
  final VoidCallback removeRow;
  final int tabID;
  final int rowID;

  const TemplateRow({
    super.key,
    required this.tabID,
    required this.rowID,
    required this.removeRow,
    //required this.animation,
  });

  @override
  ConsumerState<TemplateRow> createState() => _TemplateRowState();
}

class _TemplateRowState extends ConsumerState<TemplateRow> {
  Timer? timer;
  StreamController<int> events = StreamController<int>.broadcast();
  late int curSeconds = 0;
  late final RowItemData curRowData;
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
    curRowData = AllData.allData[widget.tabID].rows[widget.rowID];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DeletionTypes deletionType = ref.watch(deletionTypeProvider);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: Colors.grey[300],
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
                                      border: UnderlineInputBorder(),
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
                                    border: UnderlineInputBorder(),
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
                                    border: UnderlineInputBorder(),
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
                                border: UnderlineInputBorder(),
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
                                      border: UnderlineInputBorder(),
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
                                    border: UnderlineInputBorder(),
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
                                  border: UnderlineInputBorder(),
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
                              child:
                                  Text(":", textScaler: TextScaler.linear(2.0)),
                            ),
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: TextEditingController(
                                    text: (tempSeconds).toString()),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  labelText: 'Sec',
                                  border: UnderlineInputBorder(),
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
                              decoration: const InputDecoration(
                                labelText: 'Exercise',
                                border: UnderlineInputBorder(),
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
                                  border: UnderlineInputBorder(),
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
                              child:
                                  Text(":", textScaler: TextScaler.linear(2.0)),
                            ),
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: TextEditingController(
                                    text: (tempSeconds).toString()),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  labelText: 'Sec',
                                  border: UnderlineInputBorder(),
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
              if (!editMode && curRowData.type == 0) //VIEW REPS
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      startTimer();
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
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 8, 8, 1),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
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
                      startTimer();
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
              Column(
                // End buttons
                children: [
                  if (editMode)
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            editMode = !editMode;
                            //TODO: die sachen hier speichern
                            curRowData.set = tempSet;
                            curRowData.weight = tempWeight;
                            curRowData.reps = tempReps;
                            curRowData.exercise = tempExercise;
                            curRowData.seconds =
                                (tempMinutes * 60) + (tempSeconds % 60);
                            resetEditFields();
                          });
                        },
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(CircleBorder()),
                        ),
                        child: const Icon(Icons.save)),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        editMode = !editMode;
                        if (editMode) {
                          tempSet = curRowData.set;
                          tempWeight = curRowData.weight;
                          tempReps = curRowData.reps;
                          tempExercise = curRowData.exercise;
                          tempMinutes = curRowData.seconds ~/ 60;
                          tempSeconds = curRowData.seconds % 60;
                        } else {
                          resetEditFields();
                        }
                      });
                    },
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder()),
                    ),
                    child: editMode
                        ? const Icon(Icons.cancel)
                        : const Icon(Icons.edit),
                  ),
                  if (editMode)
                    ElevatedButton(
                      onPressed: () {
                        if (deletionType == DeletionTypes.always) {
                          AllDialogs.showDeleteDialog(
                            context,
                            "Row ${curRowData.exercise}",
                            widget.removeRow,
                          );
                        } else {
                          widget.removeRow();
                        }
                      },
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(CircleBorder()),
                      ),
                      child: const Icon(Icons.delete),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    curSeconds = AllData.allData[widget.tabID].rows[widget.rowID].seconds;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      events.add(--curSeconds);
    });
  }

  void resetEditFields() {
    tempSet = "";
    tempWeight = "";
    tempReps = "";
    tempExercise = "";
    tempMinutes = 0;
    tempSeconds = 0;
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