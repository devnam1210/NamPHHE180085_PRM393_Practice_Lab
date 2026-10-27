import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _displayName = 'Đang tải...';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    // Ưu tiên hiển thị tên từ Firebase trước, nếu không có thì lấy từ SharedPreferences
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    
    if (firebaseUser != null) {
      setState(() => _displayName = firebaseUser.displayName ?? 'Google User');
    } else {
      final prefs = await SharedPreferences.getInstance();
      setState(() => _displayName = prefs.getString('username') ?? 'API User');
    }
  }

  Future<void> _handleLogout() async {
    // 1. Xóa session lưu bằng API
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // 2. Xóa session lưu bằng Google Firebase
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();

    // 3. Đá về trang Login
    if (mounted) Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang Chủ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: 'Đăng xuất',
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 24),
            Text(
              'Xin chào, $_displayName!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Bạn đã hoàn thành Lab 10 Full Project.'),
          ],
        ),
      ),
    );
  }
}