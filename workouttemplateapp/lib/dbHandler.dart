import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

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
  int seconds;

  RowItemData({
    required this.type,
    this.set = '',
    this.weight = '',
    this.reps = '',
    this.seconds = 0,
    this.exercise = '',
  });
}

class SettingsData {
  static bool lightMode = true;
  static DeletionConfirmation? deletionType = DeletionConfirmation.always;
  static bool vibration = true;
  static double volume = 0;
}

class AllData {
  static List<PlanItemData> allData = [
    PlanItemData("Plan1"),
  ];
}

enum DeletionConfirmation { always, plans, never }
