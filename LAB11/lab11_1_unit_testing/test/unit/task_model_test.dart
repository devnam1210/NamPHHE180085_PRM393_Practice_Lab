import 'package:flutter_test/flutter_test.dart';
import 'package:lab11_1_unit_testing/models/task.dart'; 

void main() {
  group('Task model - Demo 11.1', () {
    test('Giá trị completed mặc định phải là false', () {
      final task = Task(id: '1', title: 'Học Unit Test');
      expect(task.completed, false);
    });

    test('toggle() should switch completed state', () {
      final task = Task(id: '1', title: 'Demo task');
      expect(task.completed, false);
      task.toggle();
      expect(task.completed, true);
      task.toggle();
      expect(task.completed, false);
    });
  });
}