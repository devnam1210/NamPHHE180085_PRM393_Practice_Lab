import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:lab11_1_unit_testing/providers/task_provider.dart';
import 'package:lab11_1_unit_testing/repository/task_repository.dart';
import 'package:lab11_1_unit_testing/screens/task_list_screen.dart';

// Hàm bọc Widget cần test với Provider và MaterialApp
Widget createTaskListTestApp() {
  return ChangeNotifierProvider(
    create: (_) => TaskProvider(TaskRepository()),
    child: const MaterialApp(
      home: TaskListScreen(),
    ),
  );
}

void main() {
  group('Task List Widget Tests - Lab 11.2', () {
    
    testWidgets('Phải hiển thị trạng thái trống ban đầu', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createTaskListTestApp());
      // Assert
      // Dùng findsOneWidget để kiểm tra xem có đúng 1 dòng chữ này trên màn hình không
      expect(find.text('No tasks yet. Add one!'), findsOneWidget);
    });

    testWidgets('Thêm một task phải hiển thị lên danh sách', (WidgetTester tester) async {
      // STEP 1 - Arrange
      await tester.pumpWidget(createTaskListTestApp());
      expect(find.text('No tasks yet. Add one!'), findsOneWidget);

      // STEP 2 - Act (Mô phỏng hành động người dùng)
      // Tìm ô nhập liệu bằng Key và gõ chữ 'Buy milk'
      await tester.enterText(find.byKey(const Key('taskTextField')), 'Buy milk');
      
      // Bấm vào nút Add
      await tester.tap(find.byKey(const Key('addTaskButton')));
      
      // Render lại giao diện sau khi bấm nút (Rất quan trọng trong Widget Test)
      await tester.pump(); 

      // STEP 3 - Assert (Xác thực kết quả)
      expect(find.text('Buy milk'), findsOneWidget); // Task mới phải xuất hiện
      expect(find.text('No tasks yet. Add one!'), findsNothing); // Chữ báo trống phải biến mất
    });

    testWidgets('Thêm nhiều tasks sẽ hiển thị tất cả', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createTaskListTestApp());
      // Act - Thêm task 1
      await tester.enterText(find.byKey(const Key('taskTextField')), 'Task 1');
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();
      // Act - Thêm task 2
      await tester.enterText(find.byKey(const Key('taskTextField')), 'Task 2');
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();
      // Assert
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });
  });
}