import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanItemData {
  String name;
  final Icon icon = const Icon(Icons.fitness_center);
  final List<RowItemData> rows = [];

  PlanItemData(this.name) {
    rows.add(RowItemData(type: 0));
  }
}

class RowItemData {
  int type;
  String set;
  String weight;
  String reps;
  String exercise;
  String time;

  RowItemData({
    required this.type,
    this.set = '',
    this.weight = '',
    this.reps = '',
    this.time = '',
    this.exercise = '',
  });
}

class AllData {
  static List<PlanItemData> allData = [
    PlanItemData("Plan1"),
  ];
}
