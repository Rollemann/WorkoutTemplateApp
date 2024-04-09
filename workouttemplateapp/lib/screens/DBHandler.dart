import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workouttemplateapp/data_models.dart';

class DBHandler {
  static Database? _db;
  static const int _version = 1;
  static const String _tableNamePlan = "plans";
  static const String _tableNameRow = "rows";

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      _db = await openDatabase(
        join(await getDatabasesPath(), 'workout_plans.db'),
        onCreate: (db, version) => _createDb(db),
        onConfigure: (db) => _onConfigure(db),
        version: _version,
      );
    } catch (e) {
      print(e);
    }
  }

  ///
  /// Methods for Plans
  ///

  static Future<List<PlanItemData>> allPlans() async {
    log("allPlans function called");
    final List<Map<String, Object?>> planMaps =
        await _db!.query(_tableNamePlan);
    log(planMaps.toString());
    return [
      for (final planJson in planMaps) PlanItemData.fromJson(planJson),
    ];
  }

  static Future<int> insertPlan(PlanItemData? plan) async {
    log("Insert function called");
    return await _db!.insert(
      _tableNamePlan,
      plan!.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static deletePlan(int planId) async {
    log("deletePlan function called");
    await _db!.delete(_tableNamePlan, where: "id=?", whereArgs: [planId]);
  }

  static updatePlan(PlanItemData plan) async {
    await _db!.update(
      _tableNamePlan,
      plan.toJson(),
      where: 'id = ?',
      whereArgs: [plan.id],
    );
  }

  static swapPlans(int planId1, int planId2) async {
    log("swapPlans function called");
    _db!.execute(
      '''
        update $_tableNamePlan
        set id = (case when id = $planId1 then -$planId2 else -$planId1 end)
        where id in ($planId1, $planId2);
      ''',
    );
    _db!.execute(
      '''
        update $_tableNamePlan
        set id = - id
        where id < 0;
      ''',
    );
  }

  ///
  /// Methods for Rows
  ///

  static Future<List<RowItemData>> allRows() async {
    log("allRows function called");
    final List<Map<String, Object?>> rowMaps = await _db!.query(_tableNameRow);
    log(rowMaps.toString());
    return [
      for (final rowJson in rowMaps) RowItemData.fromJson(rowJson),
    ];
  }

  static Future<int> insertRow(RowItemData? row) async {
    log("Insert function called");
    log(row!.toJson().toString());
    return await _db!.insert(
      _tableNameRow,
      row.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<RowItemData>> allRowsOfPlan(int planId) async {
    log("allRowsOfPlan function called");
    final List<Map<String, Object?>> rowMaps = await _db!.query(
      _tableNameRow,
      where: "planId=?",
      whereArgs: [planId],
    );
    return [
      for (final rowJson in rowMaps) RowItemData.fromJson(rowJson),
    ];
  }

  static deleteRow(int rowId) async {
    await _db!.delete(_tableNameRow, where: "id=?", whereArgs: [rowId]);
  }

  static updateRow(RowItemData row) async {
    await _db!.update(
      _tableNamePlan,
      row.toJson(),
      where: 'id = ?',
      whereArgs: [row.id],
    );
  }

  static swapRows(int rowId1, int rowId2) async {
    log("swapRows function called");
    _db!.execute(
      '''
        update $_tableNameRow
        set id = (case when id = $rowId1 then -$rowId2 else -$rowId1 end)
        where id in ($rowId1, $rowId2);
      ''',
    );
    _db!.execute(
      '''
        update $_tableNameRow
        set id = - id
        where id < 0;
      ''',
    );
  }

  ///
  /// General Methods
  ///

  static void _createDb(Database db) async {
    /* db.execute(
      'DROP TABLE IF EXISTS $_tableNameRow;',
    ); */
    await db.execute(
      '''
      CREATE TABLE $_tableNamePlan (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL
      )''',
    );
    await db.execute(
      '''
      CREATE TABLE $_tableNameRow (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        planId INTEGER NOT NULL, 
        type INTEGER NOT NULL, 
        rowSet TEXT, 
        weight TEXT, 
        reps TEXT, 
        exercise TEXT, 
        seconds INTEGER,
        FOREIGN KEY(planId) REFERENCES $_tableNamePlan(id) ON DELETE CASCADE ON UPDATE CASCADE
      )''',
    );
  }

  static void _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
