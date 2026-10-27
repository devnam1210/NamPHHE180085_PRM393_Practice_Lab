import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

// Đảm bảo import đúng tên project của bạn
import 'package:lab11_1_unit_testing/models/task.dart';
import 'package:lab11_1_unit_testing/providers/task_provider.dart';
import 'package:lab11_1_unit_testing/repository/task_repository.dart';
import 'package:lab11_1_unit_testing/screens/task_list_screen.dart';

// Hàm bọc giao diện và bơm sẵn (seed) một task vào Repository
Widget createTaskListWithSeededTask() {
  final repo = TaskRepository();
  // Thêm sẵn 1 task để có cái mà bấm vào
  repo.addTask(Task(id: '1', title: 'Demo task for navigation'));

  return ChangeNotifierProvider(
    create: (_) => TaskProvider(repo),
    child: const MaterialApp(
      home: TaskListScreen(),
    ),
  );
}

void main() {
  group('Navigation - Demo 11.3', () {
    testWidgets('tapping a task navigates to Task Detail screen',
        (WidgetTester tester) async {
      // STEP 1 - Arrange (Chuẩn bị UI với 1 task có sẵn)
      await tester.pumpWidget(createTaskListWithSeededTask());
      expect(find.text('Demo task for navigation'), findsOneWidget);

      // STEP 2 - Act (Thực hiện hành động)
      // Bấm vào dòng chữ của task
      await tester.tap(find.text('Demo task for navigation'));
      // Lệnh pumpAndSettle() rất quan trọng khi test điều hướng: 
      // Nó sẽ đợi cho đến khi mọi hiệu ứng chuyển cảnh (animation) kết thúc
      await tester.pumpAndSettle();
      // STEP 3 - Assert (Xác thực kết quả)
      // Kiểm tra xem tiêu đề AppBar ở trang mới có phải là 'Task Detail' không
      expect(find.text('Task Detail'), findsOneWidget);
      // Kiểm tra xem ô nhập liệu có Key là 'detailTitleField' có xuất hiện không
      expect(find.byKey(const Key('detailTitleField')), findsOneWidget);
    });
  });
}