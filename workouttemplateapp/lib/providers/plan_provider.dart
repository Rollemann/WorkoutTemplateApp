import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/screens/DBHandler.dart';
import 'package:workouttemplateapp/data_models.dart';

// Controller for change data
final planController = Provider((ref) => PlanController());
// Provider for display data
final planProvider = FutureProvider<List<PlanItemData>?>((ref) {
  final plans = ref.read(planController).getPlans();
  return plans;
});

// Controller for change data
final rowController = Provider((ref) => RowController());
// Provider for display data
final rowProvider = FutureProvider<List<RowItemData>?>((ref) {
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
