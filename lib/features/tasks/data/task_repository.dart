import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/task.dart';

class TaskRepository {
  static const String _tasksKey = 'tasks';
  final SharedPreferences _prefs;

  TaskRepository(this._prefs);

  Future<List<Task>> getTasks() async {
    final tasksJson = _prefs.getStringList(_tasksKey) ?? [];
    return tasksJson.map((json) => Task.fromJson(jsonDecode(json))).toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final tasksJson = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await _prefs.setStringList(_tasksKey, tasksJson);
  }
}
