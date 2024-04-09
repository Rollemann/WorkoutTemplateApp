import 'package:flutter/material.dart';

class PlanItemData {
  final int id;
  final String name;
  final int position;
  final Icon icon = const Icon(Icons.fitness_center);

  PlanItemData({required this.name, required this.position, this.id = -1});

  PlanItemData renamePlan(String newName) {
    return PlanItemData(name: newName, id: id, position: position);
  }

  factory PlanItemData.fromJson(Map<String, dynamic> planJson) {
    return PlanItemData(
        id: planJson['id'],
        name: planJson['name'],
        position: planJson['position']);
  }

  Map<String, dynamic> toJson() {
    return id > 0
        ? {'id': id, 'name': name, 'position': position}
        : {'name': name, 'position': position};
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
  int position;

  RowItemData({
    required this.type,
    required this.planId,
    required this.position,
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
        seconds = json['seconds'],
        position = json['position'];

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
          'position': position,
        }
      : {
          'planId': planId,
          'type': type,
          'rowSet': set,
          'weight': weight,
          'reps': reps,
          'exercise': exercise,
          'seconds': seconds,
          'position': position,
        };
}
