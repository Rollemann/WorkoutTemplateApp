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

class AllData {
  static List<PlanItemData> allData = [
    PlanItemData("Plan1"),
  ];
}

enum DeletionConfirmationTypes { always, plans, never }

class SettingsData {
  static bool lightMode = true;
  static DeletionConfirmationTypes deletionType =
      DeletionConfirmationTypes.always;
  static bool vibration = true;
  static double volume = 0;

  static void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    lightMode = prefs.getBool('lightMode') ?? lightMode;

    String? deletionTypeString = prefs.getString('deletionType');
    deletionType = deletionTypeString != null
        ? _stringToDeletionType(deletionTypeString)
        : deletionType;

    vibration = prefs.getBool('vibration') ?? vibration;

    volume = prefs.getDouble('volume') ?? volume;
  }

  static void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('lightMode', lightMode);
    prefs.setString('deletionType', _deletionTypeToString(deletionType));
    prefs.setBool('vibration', vibration);
    prefs.setDouble('volume', volume);
  }

  static String _deletionTypeToString(DeletionConfirmationTypes deletionType) {
    if (deletionType == DeletionConfirmationTypes.always) {
      return "always";
    }
    if (deletionType == DeletionConfirmationTypes.plans) {
      return "plans";
    }
    return "never";
  }

  static DeletionConfirmationTypes _stringToDeletionType(String deletionType) {
    if (deletionType == "always") {
      return DeletionConfirmationTypes.always;
    }
    if (deletionType == "plans") {
      return DeletionConfirmationTypes.plans;
    }
    return DeletionConfirmationTypes.never;
  }
}
