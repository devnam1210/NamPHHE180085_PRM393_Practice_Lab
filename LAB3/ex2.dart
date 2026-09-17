import 'dart:convert';

class User {
  String name;
  String email;

  User.fromJson(Map<String, dynamic> json) : name = json['name'], email = json['email'];
}

Future<List<User>> fetchUsers() async {
  String jsonString = '[{"name": "Nam", "email": "nam@test.com"}, {"name": "Trang", "email": "trang@test.com"}]';
  List<dynamic> parsedList = jsonDecode(jsonString);
  return parsedList.map((json) => User.fromJson(json)).toList();
}

void main() async {
  print("--- EXERCISE 2 ---");
  List<User> users = await fetchUsers();
  for (var user in users) {
    print("User: ${user.name} - ${user.email}");
  }
}