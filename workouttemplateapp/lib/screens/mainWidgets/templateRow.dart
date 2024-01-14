import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workouttemplateapp/allDialogs.dart';
import 'package:workouttemplateapp/dbHandler.dart';

class TemplateRow extends StatefulWidget {
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
  State<TemplateRow> createState() => _TemplateRowState();
}

class _TemplateRowState extends State<TemplateRow> {
  Timer? timer;
  int seconds = 10;

  late final RowItemData curRowData =
      AllData.allData[widget.tabID].rows[widget.rowID];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.drag_handle),
              curRowData.type < 2
                  ? (Flexible(
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
                                      controller: TextEditingController(
                                          text: curRowData.set),
                                      decoration: const InputDecoration(
                                        labelText: 'Set',
                                        border: UnderlineInputBorder(),
                                      ),
                                      onChanged: (text) {
                                        curRowData.set = text;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 70,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      controller: TextEditingController(
                                          text: curRowData.weight),
                                      decoration: const InputDecoration(
                                        labelText: 'Weight',
                                        border: UnderlineInputBorder(),
                                      ),
                                      onChanged: (text) {
                                        curRowData.weight = text;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 70,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      keyboardType: curRowData.type == 0
                                          ? TextInputType.number
                                          : TextInputType.datetime,
                                      controller: TextEditingController(
                                          text: curRowData.reps),
                                      decoration: InputDecoration(
                                        labelText: curRowData.type == 0
                                            ? 'Reps'
                                            : 'Time',
                                        border: const UnderlineInputBorder(),
                                      ),
                                      onChanged: (text) {
                                        curRowData.reps = text;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: TextEditingController(
                                    text: curRowData.exercise),
                                decoration: const InputDecoration(
                                  labelText: 'Exercise',
                                  border: UnderlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  curRowData.exercise = text;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  : Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Pause:",
                              textScaler: TextScaler.linear(1.5),
                            ),
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: TextEditingController(
                                    text: (seconds ~/ 60).toString()),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  labelText: 'Min',
                                  border: UnderlineInputBorder(),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onSubmitted: (value) {
                                  int tempMinValue = 0;
                                  if (value != "") {
                                    int intValue = int.parse(value);
                                    tempMinValue =
                                        intValue < 999 ? intValue : 999;
                                  } else {
                                    tempMinValue = 0;
                                  }
                                  setState(() {
                                    seconds =
                                        (tempMinValue * 60) + (seconds % 60);
                                  });
                                  log(tempMinValue.toString());
                                  log(seconds.toString());
                                },
                              ),
                            ),
                            const Text(":"),
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: TextEditingController(
                                    text: (seconds % 60)
                                        .toString()
                                        .padLeft(2, "0")),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  labelText: 'Sec',
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: startTimer,
                                style: const ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                        CircleBorder())),
                                child: const Icon(Icons.play_arrow_rounded)),
                          ],
                        ),
                      ),
                    ),
              ElevatedButton(
                onPressed: () => {
                  AllDialogs.showDeleteDialog(
                    context,
                    "Row ${curRowData.exercise}",
                    widget.removeRow,
                  )
                },
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(CircleBorder())),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        --seconds;
      });
    });
  }

  /* String secondsToTimeString(int sec) {
    final String minStr = (sec ~/ 60).toString().padLeft(2, "0");
    final String secStr = (sec % 60).toString().padLeft(2, "0");
    return "$minStr:$secStr";
  } */
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