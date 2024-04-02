import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_provider.g.dart';

@riverpod
class TaskProvider extends _$TaskProvider {
  @override
  List<Task> build() {
    return List.empty();
  }
}

class Task {
  final String name;
  final bool completed;

  Task(this.name, this.completed);
}
