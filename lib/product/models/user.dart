class User {
  late String role;
  late String name;
  late String email;
  late String id;

  User(
      {required this.role,
      required this.name,
      required this.email,
      required this.id});

  User.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    name = json['name'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['role'] = role;
    data['name'] = name;
    data['email'] = email;
    data['id'] = id;
    return data;
  }
}
