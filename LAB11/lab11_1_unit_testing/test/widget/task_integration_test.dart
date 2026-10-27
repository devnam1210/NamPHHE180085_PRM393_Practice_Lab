import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:lab11_1_unit_testing/providers/task_provider.dart';
import 'package:lab11_1_unit_testing/repository/task_repository.dart';
import 'package:lab11_1_unit_testing/screens/task_list_screen.dart';

Widget createFullAppForIntegration() {
  return ChangeNotifierProvider(
    create: (_) => TaskProvider(TaskRepository()),
    child: const MaterialApp(
      home: TaskListScreen(),
    ),
  );
}

void main() {
  group('Integration flow - Demo 11.4', () {
    testWidgets('add, open detail, edit, save and return to updated list',
        (WidgetTester tester) async {
      // STEP 1 - Arrange (Khởi động toàn bộ app)
      await tester.pumpWidget(createFullAppForIntegration());

      // STEP 2 - Act: Thêm một task mới
      await tester.enterText(
        find.byKey(const Key('taskTextField')),
        'Original title',
      );
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump(); // Cập nhật UI danh sách

      // Act: Mở chi tiết task vừa thêm
      await tester.tap(find.text('Original title'));
      await tester.pumpAndSettle(); // Chờ chuyển trang xong
      expect(find.text('Task Detail'), findsOneWidget); // Xác nhận đã vào trong

      // Act: Sửa tiêu đề
      await tester.enterText(
        find.byKey(const Key('detailTitleField')),
        'Updated title',
      );
      await tester.tap(find.byKey(const Key('detailSaveButton')));
      await tester.pumpAndSettle(); // Chờ hiệu ứng quay lại trang trước kết thúc

      // STEP 3 - Assert (Xác thực kết quả luồng)
      // Chữ mới phải xuất hiện, chữ cũ phải biến mất
      expect(find.text('Updated title'), findsOneWidget);
      expect(find.text('Original title'), findsNothing);
    });
  });
}