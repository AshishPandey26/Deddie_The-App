import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task_repository.dart';
import '../domain/task.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TaskRepository(prefs);
});

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TasksNotifier(repository);
});

class TasksNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repository;

  TasksNotifier(this._repository) : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    state = await _repository.getTasks();
  }

  Future<void> addTask(Task task) async {
    state = [...state, task];
    await _repository.saveTasks(state);
  }

  Future<void> deleteTask(String taskId) async {
    state = state.where((task) => task.id != taskId).toList();
    await _repository.saveTasks(state);
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    state =
        state.map((task) {
          if (task.id == taskId) {
            return Task(
              id: task.id,
              title: task.title,
              description: task.description,
              deadline: task.deadline,
              isCompleted: !task.isCompleted,
              postToLinkedIn: task.postToLinkedIn,
              postToTwitter: task.postToTwitter,
            );
          }
          return task;
        }).toList();
    await _repository.saveTasks(state);
  }
}
