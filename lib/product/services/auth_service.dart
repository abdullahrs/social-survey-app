import 'dart:convert';
import 'package:anket/product/models/user.dart';
import 'package:http/http.dart' as http;


class AuthService {

  static Future<bool> login({required String email, required String password})async{
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://fd7a1991-8d21-499f-aa7b-231db6c4d466.mock.pstmn.io//auth/login'));
      // TODO: change
      // request.bodyFields = {'email': mailController.text, 'password': passwordController.text};
      request.bodyFields = {'email': 'johndoe@x.com', 'password': 'johndoe123'};
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String jsonString = await response.stream.bytesToString();
        var result = json.decode(jsonString);
        UserModel user = UserModel.fromJson(result);
        print(user is UserModel);
      } else {
        print(response.reasonPhrase);
      }


    return false;
  }

}