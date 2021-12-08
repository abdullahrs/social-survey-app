import 'dart:convert';
import 'package:anket/product/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<UserModel?> login(
      {required String email, required String password}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    // https://fd7a1991-8d21-499f-aa7b-231db6c4d466.mock.pstmn.io//auth/login
    // http://207.154.235.107:3000/v1/auth/login
    var request = http.Request(
        'POST', Uri.parse('https://fd7a1991-8d21-499f-aa7b-231db6c4d466.mock.pstmn.io//auth/login'));
    request.bodyFields = {'email': email, 'password': password};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      var result = json.decode(jsonString);
      UserModel user = UserModel.fromJson(result);
      return user;
    } else if (response.statusCode == 400) {
      UserModel user = UserModel(user: null, tokens: null);
      return user;
    } else {
      // print(response.reasonPhrase);
      // throw Exception(response.reasonPhrase);
      return null;
    }
  }

  static Future<UserModel?> register(
      {required String name,
      required String email,
      required String password}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    // https://fd7a1991-8d21-499f-aa7b-231db6c4d466.mock.pstmn.io//auth/register
    // http://207.154.235.107:3000/v1/auth/login
    var request = http.Request(
        'POST', Uri.parse('https://fd7a1991-8d21-499f-aa7b-231db6c4d466.mock.pstmn.io//auth/register'));
    request.bodyFields = {'name': name, 'email': email, 'password': password};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      var result = json.decode(jsonString);
      UserModel user = UserModel.fromJson(result);
      return user;
    } else if (response.statusCode == 400) {
      UserModel user = UserModel(user: null, tokens: null);
      return user;
    } else {
      // print(response.reasonPhrase);
      // throw Exception(response.reasonPhrase);
      return null;
    }
  }
}
