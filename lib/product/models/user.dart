import 'package:anket/product/models/token.dart';

class UserModel {
  User? user;
  Tokens? tokens;

  UserModel({required this.user, required this.tokens});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (tokens != null) {
      data['tokens'] = tokens!.toJson();
    }
    return data;
  }
}

class User {
  String? role;
  String? name;
  String? email;
  String? id;

  User({this.role, this.name, this.email, this.id});

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
