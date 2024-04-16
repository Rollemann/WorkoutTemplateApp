import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/data/db_handler.dart';
import 'package:workouttemplateapp/data/data_models.dart';

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
    final List<PlanItemData> plans = await DBHandler.allPlans();
    _reorderPositions(plans);
  }

  void updatePlan(PlanItemData plan) async {
    await DBHandler.updatePlan(plan);
  }

  void reorderPlans(List<PlanItemData> plans, int oldIndex, int newIndex) {
    final PlanItemData curPlan = plans.removeAt(oldIndex);
    plans.insert(newIndex, curPlan);
    _reorderPositions(plans);
  }

  void _reorderPositions(plans) {
    for (var i = 0; i < plans.length; i++) {
      PlanItemData plan = plans[i];
      if (plan.position != i) {
        PlanItemData newPlan = plan.setPosition(i);
        DBHandler.updatePlan(newPlan);
      }
    }
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

  void deleteRow(int rowId, int planId) async {
    await DBHandler.deleteRow(rowId);
    List<RowItemData> planRows = (await DBHandler.allRows())
        .where((row) => row.planId == planId)
        .toList();
    _reorderPositions(planRows);
  }

  void updateRow(RowItemData row) async {
    await DBHandler.updateRow(row);
  }

  void reorderRows(
      List<RowItemData> planRows, int oldIndex, int newIndex, int planId) {
    final RowItemData curRow = planRows.removeAt(oldIndex);
    planRows.insert(newIndex, curRow);
    _reorderPositions(planRows);
  }

  void _reorderPositions(List<RowItemData> planRows) {
    for (var i = 0; i < planRows.length; i++) {
      RowItemData row = planRows[i];
      if (row.position != i) {
        row.position = i;
        DBHandler.updateRow(row);
      }
    }
  }
}
