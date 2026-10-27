import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 10.5 - Notification',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NotificationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // 1. Khởi tạo plugin thông báo
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _setupNotifications();
  }

  Future<void> _setupNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    // 3. Yêu cầu quyền thông báo trên Android 13+
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> _showNotification() async {
    // 4. Cấu hình chi tiết cho thông báo (Kênh, độ ưu tiên, âm thanh)
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'lab10_channel', // ID của kênh
      'Lab 10 Notifications', // Tên kênh
      channelDescription: 'Kênh hiển thị thông báo cho Lab 10',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      id: 0, // ID của thông báo
      title: 'Đăng nhập thành công!', // Tiêu đề
      body: 'Chào mừng bạn đã quay trở lại ứng dụng.', // Nội dung
      notificationDetails: notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 10.5 - Local Notification')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications_active, size: 80, color: Colors.amber),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _showNotification, // Gọi hàm hiển thị thông báo khi bấm
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Kiểm tra Thông báo', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}