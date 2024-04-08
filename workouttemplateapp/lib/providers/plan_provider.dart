import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouttemplateapp/screens/DBHandler.dart';
import 'package:workouttemplateapp/data_models.dart';
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

  void addPlan(PlanItemData plan, [int newPlanIndex = -1]) {
    newPlanIndex < 0 ? state.add(plan) : state.insert(newPlanIndex, plan);
    state = [...state];
    _savePlans();
  }

  PlanItemData removePlan(int index) {
    PlanItemData plan = state.removeAt(index);
    state = [...state];
    _savePlans();
    return plan;
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

///
/// new provider with db
///

// Controller for change data
final planController = Provider((ref) => PlanController());
// TODO: rename in planProvider
// Provider for display data
final getPlanController = FutureProvider<List<PlanItemData>?>((ref) {
  final plans = ref.read(planController).getPlans();
  return plans;
});

// Controller for change data
final rowController = Provider((ref) => RowController());
// TODO: rename in rowProvider
// Provider for display data
final getRowController = FutureProvider<List<RowItemData>?>((ref) {
  final rows = ref.read(rowController).getRows();
  return rows;
});

class PlanController {
  List<PlanItemData> plans = [];

  Future<List<PlanItemData>?> getPlans() async {
    try {
      List<PlanItemData> plans = await DBHandler.allPlans();
      return plans;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<int> addPlan(PlanItemData? plan) async {
    return await DBHandler.insertPlan(plan!);
  }

  void deletePlan(int planId) async {
    await DBHandler.deletePlan(planId);
  }

  void updatePlan(PlanItemData plan) async {
    await DBHandler.updatePlan(plan);
  }

  void swapPlans(int planId1, int planId2) async {
    await DBHandler.swapPlans(planId1, planId2);
  }
}

class RowController {
  List<RowItemData> rows = [];

  Future<List<RowItemData>?> getRows() async {
    try {
      List<RowItemData> rows = await DBHandler.allRows();
      return rows;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  void addRow(RowItemData row) async {
    await DBHandler.insertRow(row);
  }

  void deleteRow(int rowId) async {
    await DBHandler.deleteRow(rowId);
  }

  void updateRow(RowItemData row) async {
    await DBHandler.updateRow(row);
  }

  void swapRows(int rowId1, int rowId2) async {
    await DBHandler.swapRows(rowId1, rowId2);
  }
}
