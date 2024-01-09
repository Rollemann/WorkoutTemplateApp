import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanItemData {
  String name;
  final Icon icon = const Icon(Icons.fitness_center);
  final List<RowItemData> rows = [];

  PlanItemData(this.name) {
    rows.add(RowItemData());
  }
}

class RowItemData {
  String set;
  String weight;
  String reps;
  String exercise;

  RowItemData(
      {this.set = '', this.weight = '', this.reps = '', this.exercise = ''});
}

class AllData {
  static List<PlanItemData> allData = [
    PlanItemData("Plan1"),
  ];
}
