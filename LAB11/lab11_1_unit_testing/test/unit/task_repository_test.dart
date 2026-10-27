import 'package:flutter_test/flutter_test.dart';
import 'package:lab11_1_unit_testing/models/task.dart'; 
import 'package:lab11_1_unit_testing/repository/task_repository.dart';

void main() {
  group('Task Repository Tests - Lab 11.1', () {
    late TaskRepository repository;
    setUp(() {
      repository = TaskRepository();
    });

    test('addTask() phải thêm task vào repository', () {
      final task = Task(id: '1', title: 'Task đầu tiên');
      repository.addTask(task);
      expect(repository.tasks.length, 1);
      expect(repository.tasks.first.title, 'Task đầu tiên');
    });

    test('updateTask() phải cập nhật task có sẵn', () {
      final initialTask = Task(id: '1', title: 'Task cũ');
      repository.addTask(initialTask);
      final updatedTask = Task(id: '1', title: 'Task đã sửa');
      repository.updateTask(updatedTask);
      expect(repository.tasks.length, 1);
      expect(repository.tasks.first.title, 'Task đã sửa');
    });

    test('deleteTask() phải xóa task khỏi repository', () {
      final task = Task(id: '1', title: 'Task cần xóa');
      repository.addTask(task);
      expect(repository.tasks.length, 1);
      repository.deleteTask('1');
      expect(repository.tasks.isEmpty, true);
    });
  });
}