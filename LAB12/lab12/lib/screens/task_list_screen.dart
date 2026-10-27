import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Tải trước ảnh để tránh giật lag khi render lần đầu
    precacheImage(const AssetImage('assets/logo.png'), context);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly - Task List'),
      ),
      body: Column(
        children: [
          // Phần nhập liệu tĩnh (Không bị rebuild khi danh sách thay đổi)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 48,
                  height: 48,
                ),
                const SizedBox(width: 12), // Khoảng cách
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
                      Provider.of<TaskProvider>(context, listen: false)
                          .addTask(_textController.text.trim());
                      _textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          
          // Phần danh sách sử dụng Selector để chỉ rebuild đúng chỗ này
          Expanded(
            child: Selector<TaskProvider, List<Task>>(
              selector: (context, provider) => provider.tasks,
              builder: (context, tasks, child) {
                if (tasks.isEmpty) {
                  return const Center(child: Text('No tasks yet. Add one!'));
                }
                
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TaskDetailScreen(task: task),
                          ),
                        );
                      },
                      // Gọi Widget đã tách và truyền ValueKey để Flutter so sánh hiệu quả hơn
                      child: TaskTile(
                        key: ValueKey(task.id), 
                        task: task,
                        onToggleCompleted: () =>
                            Provider.of<TaskProvider>(context, listen: false)
                                .toggleTask(task.id),
                        onDelete: () =>
                            Provider.of<TaskProvider>(context, listen: false)
                                .deleteTask(task.id),
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