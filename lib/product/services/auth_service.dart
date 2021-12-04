import 'dart:convert';
import 'package:anket/product/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<UserModel?> login(
      {required String email, required String password}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://fd7a1991-8d21-499f-aa7b-231db6c4d466.mock.pstmn.io//auth/login'));
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
      print(response.reasonPhrase);
      return null;
    }
  }
}
