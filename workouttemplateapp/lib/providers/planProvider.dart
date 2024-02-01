import 'dart:convert';

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

    Iterable plans = json.decode(prefs.getString("plans")!);
    state = List<PlanItemData>.from(
        plans.map((plan) => PlanItemData.fromJson(plan)));
  }

  addPlan(PlanItemData plan) {
    state = [plan, ...state];
    prefs.setString("plans", json.encode(state));
  }
}

final planProvider =
    StateNotifierProvider<PlanNotifier, List<PlanItemData>>((ref) {
  final pn = PlanNotifier(ref.watch(sharedPreferencesProvider));
  pn._initialize();
  return pn;
});
