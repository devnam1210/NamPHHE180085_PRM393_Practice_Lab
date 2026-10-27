import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<User?> signInWithGoogle() async {
    try {
      // 1. Kích hoạt bảng chọn tài khoản Google
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      // 2. Lấy thông tin xác thực (trong v7.x, authentication là thuộc tính đồng bộ)
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // 3. Tạo chứng chỉ (Credential) để gửi lên Firebase bằng idToken
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 4. Đăng nhập vào Firebase bằng chứng chỉ vừa tạo
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user; // Trả về thông tin người dùng (Tên, Email, Avatar...)
    } catch (e) {
      print("===== LỖI ĐĂNG NHẬP GOOGLE: $e =====");
      return null;
    }
  }
}