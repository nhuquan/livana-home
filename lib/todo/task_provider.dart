import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  List<Task> build() {
    return [];
  }

  void addTask(Task t) {
    state = [...state, t];
  }

  void removeTask(Task t) {
    state = state.where((task) => task.id != t.id).toList();
  }

  void complete(Task t) {
    state = [
      for (final task in state)
        if (task.id == t.id)
          Task(
            id: task.id,
            completed: !task.completed,
            name: task.name,
          )
        else
          task,
    ];
  }
}

class Task {
  final int id;
  final String name;
  final bool completed;

  Task({required this.name, required this.completed, required this.id});
}
