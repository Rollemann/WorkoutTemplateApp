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
  PlanItemData testPlan = PlanItemData(name: "Plan1");
  PlanItemData testPlan2 = PlanItemData(name: "Plan2");
  DBHandler.insertPlan(testPlan);
  int plan2ID = await DBHandler.insertPlan(testPlan2);
  var allPlans = await DBHandler.allPlans();
  log(allPlans.length.toString());
  await DBHandler.deletePlan(allPlans[0].id);
  PlanItemData testPlan3 = PlanItemData(name: "Plan3");
  PlanItemData testPlan4 = PlanItemData(name: "Plan4");
  int plan3ID = await DBHandler.insertPlan(testPlan3);
  await DBHandler.insertPlan(testPlan4);
  log("----------------------");
  allPlans = await DBHandler.allPlans();
  log(allPlans.length.toString());
  log("----------------------");
  await DBHandler.swapPlans(2, 4);
  allPlans = await DBHandler.allPlans();
  log(allPlans.length.toString());

  log("Row länge: ${(await DBHandler.allRows()).length}");
  log("Row länge2: $plan2ID und $plan3ID");

  RowItemData row1 = RowItemData(type: 0, planId: plan2ID);
  RowItemData row2 = RowItemData(type: 2, planId: plan2ID);
  RowItemData row3 = RowItemData(type: 0, planId: plan3ID);
  await DBHandler.insertRow(row1);
  await DBHandler.insertRow(row2);
  await DBHandler.insertRow(row3);
  log("----------------------");
  var allRows = await DBHandler.allRows();
  log(allRows.length.toString());
  await DBHandler.deletePlans(-100);
  log("----------------------");
  allRows = await DBHandler.allRows();
  log(allRows.length.toString());
  DBHandler.deleteRows(-100);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const App(),
    ),
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
