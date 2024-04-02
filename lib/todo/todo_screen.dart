import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livana/todo/task_provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: Column(
        children: [
          const TaskList(),
          TaskInput(),
        ],
      ),
    );
  }
}

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(taskListProvider);

    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final Task item = data[index];
          return ListTile(
            title: item.completed
                ? Text(item.name,
                    style:
                        const TextStyle(decoration: TextDecoration.lineThrough))
                : Text(item.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(taskListProvider.notifier).removeTask(item);
              },
            ),
            leading: IconButton(
              icon: item.completed
                  ? const Icon(Icons.check)
                  : const Icon(Icons.hourglass_empty),
              onPressed: () {
                ref.read(taskListProvider.notifier).complete(item);
              },
            ),
          );
        },
      ),
    );
  }
}

class TaskInput extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  TaskInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                ref.read(taskListProvider.notifier).addTask(Task(
                    name: _controller.value.text,
                    completed: false,
                    id: DateTime.timestamp().millisecondsSinceEpoch));
              }),
        ],
      ),
    );
  }
}
