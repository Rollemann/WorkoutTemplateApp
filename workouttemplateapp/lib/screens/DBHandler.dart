import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workouttemplateapp/template_data_models.dart';

class DBHandler {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "plans";

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

  static Future<int> insertPlan(PlanItemData? plan) async {
    log("Insert function called");
    return await _db!.insert(
      _tableName,
      plan!.toJsonDB(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<PlanItemData>> allPlans() async {
    log("allPlans function called");
    final List<Map<String, Object?>> planMaps = await _db!.query(_tableName);
    return [
      for (final planJson in planMaps) PlanItemData.fromJson(planJson),
    ];
  }

  static deletePlan(PlanItemData plan) async {
    await _db!.delete(_tableName, where: "id=?", whereArgs: [plan.id]);
  }

  /* static updatePlan(int id) async {
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  } */

  static Database? getDB() {
    return _db;
  }

  static void _createDb(Database db) {
    db.execute(
      'CREATE TABLE plans (id INTEGER PRIMARY KEY, name TEXT)',
    );
    db.execute(
      'CREATE TABLE rows (id INTEGER PRIMARY KEY, type INTEGER, set TEXT, weight TEXT, reps TEXT, exercise TEXT, seconds INTEGER, FOREIGN KEY(plan_id) REFERENCES plans(id))',
    );
  }

  static void _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
