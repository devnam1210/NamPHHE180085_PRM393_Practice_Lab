class AuthService {
  Future<String?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'student@example.com' && password == 'password123') {
      return "mock-token-121004100204140126"; // Trả về token nếu đúng
    }
    return null; 
  }
}