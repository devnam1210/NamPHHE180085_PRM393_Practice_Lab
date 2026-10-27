import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly - Task List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('taskTextField'),
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a new task',
                    ),
                  ),
                ),
                IconButton(
                  key: const Key('addTaskButton'),
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_textController.text.trim().isNotEmpty) {
                      provider.addTask(_textController.text.trim());
                      _textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: provider.tasks.isEmpty
                ? const Center(
                    child: Text('No tasks yet. Add one!'),
                  )
                : ListView.builder(
                    itemCount: provider.tasks.length,
                    itemBuilder: (context, index) {
                      final task = provider.tasks[index];
                      return ListTile(
                        leading: Checkbox(
                          value: task.completed,
                          onChanged: (_) => provider.toggleTask(task.id),
                        ),
                        title: Text(task.title),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => provider.deleteTask(task.id),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailScreen(task: task),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}