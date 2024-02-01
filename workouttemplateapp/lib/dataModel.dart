import 'dart:convert';
import 'package:flutter/material.dart';

class PlanItemData {
  String name;
  final Icon icon = const Icon(Icons.fitness_center);
  final List<RowItemData> rows;

  PlanItemData({required this.name, List<RowItemData>? rows})
      : rows = rows ?? [] {
    this.rows.add(RowItemData(type: 0));
  }

  factory PlanItemData.fromJson(Map<String, dynamic> json) {
    return PlanItemData(
      name: json['name'],
      rows: json['rows']
          .map<RowItemData>((rowItem) => RowItemData.fromJson(rowItem))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    List<String> stringRows =
        rows.map((row) => jsonEncode(row.toJson())).toList();
    return {'name': name, 'rows': stringRows};
  }
}

class RowItemData {
  int type;
  String set;
  String weight;
  String reps;
  String exercise;
  int seconds;

  RowItemData({
    required this.type,
    this.set = '',
    this.weight = '',
    this.reps = '',
    this.seconds = 0,
    this.exercise = '',
  });

  RowItemData.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        set = json['set'],
        weight = json['weight'],
        reps = json['reps'],
        exercise = json['exercise'],
        seconds = json['seconds'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'set': set,
        'weight': weight,
        'reps': reps,
        'exercise': exercise,
        'seconds': seconds,
      };
}
