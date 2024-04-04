import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workouttemplateapp/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouttemplateapp/providers/shared_preference_provider.dart';
import 'package:workouttemplateapp/screens/DBHandler.dart';
import 'package:workouttemplateapp/template_data_models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  await DBHandler.initDB();

// TestDB
  PlanItemData testPlan = PlanItemData(id: 0, name: "DBtest");
  await insertPlan(DBHandler.getDB()!, testPlan);
  log((await plans(DBHandler.getDB()!))[0].name);
  log(((await plans(DBHandler.getDB()!))[0].id).toString());

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const App(),
    ),
  );
}

Future<void> insertPlan(Database db, PlanItemData plan) async {
  await db.insert(
    'plans',
    plan.toJsonDB(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<PlanItemData>> plans(Database db) async {
  final List<Map<String, Object?>> planMaps = await db.query('plans');

  return [
    for (final {
          'id': id as int,
          'name': name as String,
        } in planMaps)
      PlanItemData(id: id, name: name),
  ];
}

///////////////////////////////////
// Test
///////////////////////////////////
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tabs = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Click Counter'),
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: createTabs(tabs),
          ),
        ),
        body: TabBarView(
          children: createTabViews(tabs),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              ++tabs;
            });
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

List<Tab> createTabs(int tabs) {
  final List<Tab> tabList = [];
  for (var i = 0; i < tabs; i++) {
    tabList.add(Tab(
      text: "Tab $i",
    ));
  }
  return tabList;
}

List<Text> createTabViews(int tabs) {
  final List<Text> allTabs = [];
  for (var i = 0; i < tabs; i++) {
    allTabs.add(Text("View $i"));
  }
  return allTabs;
}
