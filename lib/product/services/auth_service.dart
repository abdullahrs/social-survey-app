import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/token.dart';
import '../models/user.dart';

class AuthService {
  static AuthService instance = AuthService._ctor();
  AuthService._ctor();

  static const String baseURL = 'https://socialsurveyapp.software/api/v1';

  // https://fd7a1991-8d21-499f-aa7b-231db6c4d466.mock.pstmn.io//auth/register
  Future<User?> login(
      {required String email, required String password}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse('$baseURL/auth/login'));
    request.bodyFields = {'email': email, 'password': password};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    // print(jsonString);
    if (response.statusCode == 200) {
      var result = json.decode(jsonString);
      User user = User.fromJson(result);
      return user;
    } else if (response.statusCode == 401) {
      User user = User(user: null, tokens: null);
      return user;
    }
    // print(response.reasonPhrase);
    // throw Exception(response.reasonPhrase);
    return null;
  }

  Future<User?> register(
      {required String name,
      required String email,
      required String password}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse('$baseURL/auth/register'));
    request.bodyFields = {'name': name, 'email': email, 'password': password};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    // print(jsonString);
    // Created
    if (response.statusCode == 201) {
      var result = json.decode(jsonString);
      User user = User.fromJson(result);
      return user;
    }
    // Taken
    else if (response.statusCode == 400) {
      User user = User(user: null, tokens: null);
      return user;
    }
    // print(response.reasonPhrase);
    // throw Exception(response.reasonPhrase);
    return null;
  }

  Future<bool> logout({required String refreshToken}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse('$baseURL/auth/logout'));
    request.bodyFields = {'refreshToken': refreshToken};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // String jsonString = await response.stream.bytesToString();
    if (response.statusCode == 204) {
      // Sucsess
      return true;
    } else if (response.statusCode == 404) {
      // Not found
    }
    return false;
  }

  Future<Tokens?> refreshAcsessToken({required String refreshToken}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse('$baseURL/auth/register'));
    request.bodyFields = {'refreshToken': refreshToken};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    // print(jsonString);
    // Sucsess
    if (response.statusCode == 200) {
      var result = json.decode(jsonString);
      Tokens user = Tokens.fromJson(result);
      return user;
    }
    // Fail
    else if (response.statusCode == 401) {}
    return null;
  }

  /// [control] Checks if the user is logged in
  Future<bool> refreshOrLogout(
      {required bool? control, required String refreshToken}) async {
    if (control == null) {
      await refreshAcsessToken(refreshToken: refreshToken);
      return true;
    } else if (!control) {
      await logout(refreshToken: refreshToken);
      return false;
    }
    return true;
  }

  Future<String?> forgotSendMail(String email) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request =
        http.Request('POST', Uri.parse('$baseURL/auth/forgot-password'));
    request.bodyFields = {'email': email};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // String jsonString = await response.stream.bytesToString();
    if (response.statusCode == 204) {
      // Sucsess
      return response.stream.bytesToString();
    } else if (response.statusCode == 404) {
      // Not found
    }
    return null;
  }

  Future<void> resetPassword(
      {required String token, required String password}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request =
        http.Request('POST', Uri.parse('$baseURL/auth/forgot-password'));

    request.bodyFields = {'password': password};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
  }
}
