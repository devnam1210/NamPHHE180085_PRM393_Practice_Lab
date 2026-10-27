import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<String?> login(String username, String password) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username.trim(),
          'password': password.trim(),
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['accessToken'] ?? data['token']) as String?; // Trả về token chuẩn của DummyJSON
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("===== LỖI GỌI API: $e =====");
      return null;
    }
  }
}