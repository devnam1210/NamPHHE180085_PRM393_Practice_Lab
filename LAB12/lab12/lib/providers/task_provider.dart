import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../repository/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository;

  TaskProvider(this._repository);

  List<Task> get tasks => _repository.tasks;

  void addTask(String title) {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );
    _repository.addTask(task);
    notifyListeners(); // Thông báo cho UI biết để vẽ lại
  }

  void updateTask(Task task) {
    _repository.updateTask(task);
    notifyListeners();
  }

  void deleteTask(String id) {
    _repository.deleteTask(id);
    notifyListeners();
  }

  void toggleTask(String id) {
    final task = _repository.tasks.firstWhere((t) => t.id == id);
    task.toggle();
    notifyListeners();
  }
}