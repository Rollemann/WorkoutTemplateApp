import 'dart:convert';
import 'package:flutter/material.dart';

class PlanItemData {
  final int id;
  String name;
  final Icon icon = const Icon(Icons.fitness_center);
  final List<RowItemData> rows;

  PlanItemData({required this.name, this.id = -1, List<RowItemData>? rows})
      : rows = rows ?? [] {
    rows ?? this.rows.add(RowItemData(type: 0, set: "1", id: 0, planId: id));
  }

  factory PlanItemData.fromJson(Map<String, dynamic> planJson) {
    return PlanItemData(
      id: planJson['id'],
      name: planJson['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return id > 0 ? {'id': id, 'name': name} : {'name': name};
  }
}

class RowItemData {
  int id;
  int planId;
  int type;
  String set;
  String weight;
  String reps;
  String exercise;
  int seconds;

  RowItemData({
    required this.type,
    required this.planId,
    this.id = -1,
    this.set = '',
    this.weight = '',
    this.reps = '',
    this.seconds = 0,
    this.exercise = '',
  });

  RowItemData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        planId = json['planId'],
        type = json['type'],
        set = json['rowSet'],
        weight = json['weight'],
        reps = json['reps'],
        exercise = json['exercise'],
        seconds = json['seconds'];

  Map<String, dynamic> toJson() => id > 0
      ? {
          'id': id,
          'planId': planId,
          'type': type,
          'rowSet': set,
          'weight': weight,
          'reps': reps,
          'exercise': exercise,
          'seconds': seconds,
        }
      : {
          'planId': planId,
          'type': type,
          'rowSet': set,
          'weight': weight,
          'reps': reps,
          'exercise': exercise,
          'seconds': seconds,
        };
}
