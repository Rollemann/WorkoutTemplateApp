import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefs = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final lightModeProvider = StateProvider<bool>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final lightMode = preferences.getBool('lightMode') ?? true;
  ref.listenSelf((prev, curr) {
    preferences.setBool('lightMode', curr);
  });
  return lightMode;
});

final deletionTypeProvider = StateProvider<DeletionTypes>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final deletionTypeString = preferences.getString('deletionType') ?? "always";
  ref.listenSelf((prev, curr) {
    final String currString;
    if (curr == DeletionTypes.always) {
      currString = "always";
    } else if (curr == DeletionTypes.plans) {
      currString = "plans";
    } else {
      currString = "never";
    }
    preferences.setString('deletionType', currString);
  });

  if (deletionTypeString == "always") {
    return DeletionTypes.always;
  }
  if (deletionTypeString == "plans") {
    return DeletionTypes.plans;
  }
  return DeletionTypes.never;
});

enum DeletionTypes { always, plans, never }

class SettingsData2 {
  // TODO: Delete das hier
  static bool vibration = true;
  static double volume = 50;
}

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
