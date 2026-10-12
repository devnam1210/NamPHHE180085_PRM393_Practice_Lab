import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post.dart';

class ApiService {
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts1'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts'); 
    }
  }
}