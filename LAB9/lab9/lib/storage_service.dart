import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'note_model.dart';

class StorageService {
  final String fileName = "local_notes.json";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<List<Note>> loadNotes() async {
    try {
      final file = await _localFile;
      // Nếu file chưa tồn tại (chạy app lần đầu) -> Đọc từ Assets (Lab 9.1)
      if (!await file.exists()) {
        String jsonString = await rootBundle.loadString('assets/data/data.json');
        // Lưu dữ liệu mẫu này xuống Device Storage luôn (Lab 9.2)
        await file.writeAsString(jsonString);
      }
      // Đọc từ Device Storage
      String jsonString = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => Note.fromJson(e)).toList();
    } catch (e) {
      return []; // Nếu lỗi trả về list rỗng
    }
  }

  // 4. Lưu dữ liệu đè lên file cũ (Auto-save cho Lab 9.3)
  Future<void> saveNotes(List<Note> notes) async {
    final file = await _localFile;
    List<Map<String, dynamic>> jsonList = notes.map((n) => n.toJson()).toList();
    String jsonString = jsonEncode(jsonList);
    await file.writeAsString(jsonString);
  }
}