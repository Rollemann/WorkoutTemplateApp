import 'dart:developer';

import 'package:flutter/material.dart';

class TemplateRow extends StatelessWidget {
  const TemplateRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => {log("hi")},
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder())),
              child: const Icon(Icons.add),
            ),
          ],
        ),
        Container(
          color: Colors.grey[300],
          child: Row(
            children: [
              const Flexible(
                child: Column(
                  children: [
                    Row(
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
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
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
                onPressed: () => {log("bye")},
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(CircleBorder())),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
