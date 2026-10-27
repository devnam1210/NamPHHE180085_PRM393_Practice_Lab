import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'repository/task_repository.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(const TasklyApp());
}

class TasklyApp extends StatelessWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(TaskRepository()),
      child: const MaterialApp(
        title: 'Taskly',
        debugShowCheckedModeBanner: false,
        home: TaskListScreen(),
      ),
    );
  }
}