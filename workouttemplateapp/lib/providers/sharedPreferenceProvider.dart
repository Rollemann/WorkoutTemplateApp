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



/* class Task {
  final String name;
  final bool priority;

  Task({required this.name, required this.priority});

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        priority = json['priority'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'priority': priority,
      };
}

class TaskNotifier extends StateNotifier<List<Task>> {
  final SharedPreferences prefs;
  TaskNotifier(this.prefs) : super([]);

  _initialize() {
    if (!prefs.containsKey("tasks")) {
      return;
    }

    Iterable tasks = json.decode(prefs.getString("tasks")!);
    state = List<Task>.from(tasks.map((t) => Task.fromJson(t)));
  }

  addTask(Task task) {
    state = [task, ...state];
    prefs.setString("tasks", json.encode(state));
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final tn = TaskNotifier(ref.watch(sharedPreferencesProvider));
  tn._initialize();
  return tn;
});

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError()); */