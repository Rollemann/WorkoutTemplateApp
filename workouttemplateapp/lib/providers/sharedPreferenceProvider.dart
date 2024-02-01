import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workouttemplateapp/dataModel.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class AllData {
  static List<PlanItemData> allData = [
    PlanItemData(name: "Plan1"),
  ];
}
