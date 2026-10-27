import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    await Future.delayed(const Duration(seconds: 10)); // Giả lập thời gian tải
    
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('accessToken');
    final User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (mounted) {
      // Nếu có Token của API hoặc đang đăng nhập Firebase -> Vào thẳng Home
      if (token != null || firebaseUser != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Chưa đăng nhập -> Vào trang Login
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
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Đang kiểm tra đăng nhập...'),
          ],
        ),
      ),
    );
  }
}