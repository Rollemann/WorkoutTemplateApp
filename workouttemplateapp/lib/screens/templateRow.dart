import 'package:flutter/material.dart';

class TemplateRow extends StatelessWidget {
  final String text;
  //final Animation<double> animation;
  final VoidCallback removeRow;

  const TemplateRow({
    super.key,
    required this.text,
    //required this.animation,
    required this.removeRow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Icon(Icons.drag_handle),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 30.0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Set',
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 70,
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: 'Weight',
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 70,
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Reps',
                                  border: UnderlineInputBorder(),
                                ),
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
                          controller: TextEditingController(text: text),
                          decoration: const InputDecoration(
                            labelText: 'Exercise',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => {removeRow()},
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
}


//////////////// add and remove from reorder list
/* import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listItems = ['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(builder: (BuildContext context) {
        return new ReorderableListView(
          children: <Widget>[
            for (final str in listItems)
              Dismissible(
                  key: Key(str),
                  onDismissed: (direction) {
                    var delIndex = listItems.indexOf(str);
                    setState(() {
                      listItems.remove(str);
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text("Task Deleted",
                          style: TextStyle(color: Colors.white)),
                      action: SnackBarAction(
                        textColor: Colors.white,
                        label: 'Undo',
                        onPressed: () {
                          setState(() {
                            listItems.insert(delIndex, str);
                          });
                        },
                      ),
                    ));
                  },
                  child: ListTile(
                    title: Text(
                      str,
                    ),
                  ))
          ],
          onReorder: (oldIndex, newIndex) {
            setState(() {
              var replacedWidget = listItems.removeAt(oldIndex);
              listItems.insert(newIndex, replacedWidget);
            });
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          setState(() {
            listItems.add('D');
          }),
        },
      ),
    );
  }
} */



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