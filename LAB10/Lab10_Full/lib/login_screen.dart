import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// Gọi helper để dùng flutterLocalNotificationsPlugin
import 'notification_helper.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController(text: 'emilys');
  final TextEditingController _passController = TextEditingController(text: 'emilyspass');
  bool _isLoading = false;

  // Hàm hiển thị thông báo
  Future<void> _showSuccessNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'lab10_channel',
      'Lab 10 Auth',
      channelDescription: 'Channel for Lab 10 notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);
    
    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: 'Đăng nhập thành công!',
      body: 'Chào mừng bạn quay lại.',
      notificationDetails: platformDetails,
      payload: 'payload',
    );
  }

  // Đăng nhập bằng DummyJSON API
  Future<void> _loginWithAPI() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse('https://dummyjson.com/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _userController.text.trim(),
          'password': _passController.text.trim(),
          'expiresInMins': 30,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        
        await prefs.setString('accessToken', data['accessToken']); // Lưu token
        await prefs.setString('username', '${data['firstName']} ${data['lastName']}');
        
        await _showSuccessNotification(); // Gọi thông báo
        if (mounted) Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showError('Sai tài khoản hoặc mật khẩu (API)!');
      }
    } catch (e) {
      _showError('Lỗi kết nối API: $e');
    }
    setState(() => _isLoading = false);
  }

  static bool _isGoogleInitialized = false;

  // Đăng nhập bằng Google (Firebase)
  Future<void> _loginWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      if (!_isGoogleInitialized) {
        await GoogleSignIn.instance.initialize(
          serverClientId: '655813958818-c6l12crcfl0hcs6rv02snpadeanc1qeb.apps.googleusercontent.com',
        );
        _isGoogleInitialized = true;
      }
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      
      await _showSuccessNotification(); // Gọi thông báo
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _showError('Lỗi đăng nhập Google: $e');
    }
    setState(() => _isLoading = false);
  }

  void _showError(String msg) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.red)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng Nhập - Lab 10 Full')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(labelText: 'Mật khẩu', border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            _isLoading 
              ? const CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: _loginWithAPI,
                      child: const Text('Đăng nhập (REST API)'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                      icon: const Icon(Icons.g_mobiledata, color: Colors.red, size: 30),
                      label: const Text('Đăng nhập với Google'),
                      onPressed: _loginWithGoogle,
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}