import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouttemplateapp/template_data_models.dart';
import 'package:workouttemplateapp/providers/shared_preference_provider.dart';

class PlanNotifier extends StateNotifier<List<PlanItemData>> {
  final SharedPreferences prefs;
  PlanNotifier(this.prefs) : super([]);

  _initialize() {
    if (!prefs.containsKey("plans")) {
      return;
    }

    List<String> stringPlans = prefs.getStringList("plans")!;
    stringPlans.map((plan) => log(plan));
    state = stringPlans
        .map((plan) => PlanItemData.fromJson(json.decode(plan)))
        .toList();
  }

  void addPlan(PlanItemData plan) {
    state = [...state, plan];
    _savePlans();
  }

  void removePlan(int index) {
    state.removeAt(index);
    state = [...state];
    _savePlans();
  }

  void renamePlan(int index, String name) {
    state[index].name = name;
    state = [...state];
    _savePlans();
  }

  void addRow(int plan, RowItemData row, [int newRowIndex = -1]) {
    newRowIndex < 0
        ? state[plan].rows.add(row)
        : state[plan].rows.insert(newRowIndex, row);
    state = [...state];
    _savePlans();
  }

  RowItemData removeRow(int plan, int rowIndex) {
    RowItemData deletedRow = state[plan].rows.removeAt(rowIndex);
    state = [...state];
    _savePlans();
    return deletedRow;
  }

  void editRow(int plan, RowItemData newRow, int rowIndex) {
    state[plan].rows[rowIndex] = newRow;
    state = [...state];
    _savePlans();
  }

  void _savePlans() {
    List<String> stringPlans =
        state.map((plan) => json.encode(plan.toJson())).toList();
    prefs.setStringList("plans", stringPlans);
  }
}

final planProvider =
    StateNotifierProvider<PlanNotifier, List<PlanItemData>>((ref) {
  final pn = PlanNotifier(ref.watch(sharedPreferencesProvider));
  pn._initialize();
  return pn;
});
