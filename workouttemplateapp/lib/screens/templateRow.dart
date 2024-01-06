import 'package:flutter/material.dart';

class TemplateRow extends StatelessWidget {
  final String text;
  final Animation<double> animation;
  final VoidCallback addRow;
  final VoidCallback removeRow;

  const TemplateRow({
    super.key,
    required this.text,
    required this.animation,
    required this.addRow,
    required this.removeRow,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      //key: ValueKey(text), TODO: falls flackern auftritt beim löschen
      sizeFactor: animation,
      child: Column(
        children: [
          Container(
            color: Colors.grey[300],
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Flexible(
                            child: Padding(
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
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: 'Weight',
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
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
                        ],
                      ),
                      Row(
                        children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => {addRow()},
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(CircleBorder())),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
