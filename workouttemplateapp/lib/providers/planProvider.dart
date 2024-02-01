import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouttemplateapp/dataModel.dart';
import 'package:workouttemplateapp/providers/sharedPreferenceProvider.dart';

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

  addPlan(PlanItemData plan) {
    state = [...state, plan];
    _savePlans();
  }

  removePlan(int index) {
    state.removeAt(index);
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
