import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(milliseconds: 10000));
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token'); // Lấy token từ bộ nhớ máy
    if (mounted) {
      if (token != null && token.isNotEmpty) {
        // Nếu có token -> Đi thẳng vào Home
        Navigator.pushReplacementNamed(context, '/home', arguments: token);
      } else {
        // Nếu không có token -> Bắt đăng nhập
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flight_takeoff, size: 80, color: Colors.blue),
            SizedBox(height: 16),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Đang kiểm tra phiên đăng nhập..."),
          ],
        ),
      ),
    );
  }
}