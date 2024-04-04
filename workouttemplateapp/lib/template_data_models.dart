import 'dart:convert';
import 'package:flutter/material.dart';

class PlanItemData {
  final int id;
  String name;
  final Icon icon = const Icon(Icons.fitness_center);
  final List<RowItemData> rows;

  PlanItemData({required this.id, required this.name, List<RowItemData>? rows})
      : rows = rows ?? [] {
    rows ?? this.rows.add(RowItemData(type: 0, set: "1"));
  }

  factory PlanItemData.fromJson(Map<String, dynamic> planJson) {
    return PlanItemData(
      id: planJson['id'],
      name: planJson['name'],
      rows: planJson['rows']
          .map<RowItemData>(
              (rowItem) => RowItemData.fromJson(json.decode(rowItem)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    List<String> stringRows =
        rows.map((row) => jsonEncode(row.toJson())).toList();
    return {'id': id, 'name': name, 'rows': stringRows};
  }

  Map<String, dynamic> toJsonDB() {
    return {'id': id, 'name': name};
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
