class User{
  int id;
  String name;
  // To do 1
  String? email;

  User({required this.id, required this.name, this.email});

  // To do 2
  factory User.fromJson(Map<String, dynamic> json){
      return User(
      id: json['id'],
      name: json['name'] ?? "Khách",
      email: json['email'],
    );  
  }

  void showProfile(){
    // To do 3
    print("ID: $id | Tên: $name | Email: ${email ?? 'Chưa cập nhật'}");
  }

}

void main(){
  Map<String, dynamic> rawData1 = {"id": 1, "name": "Nam", "email": "nam@fpt.edu.vn"};
  Map<String, dynamic> rawData2 = {"id": 2, "name": null, "email": null};

  // To do 4
  User user1 = User.fromJson(rawData1);
  User user2 = User.fromJson(rawData2);

  user1.showProfile();
  user2.showProfile();
}