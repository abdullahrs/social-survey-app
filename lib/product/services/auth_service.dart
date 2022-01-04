import 'dart:convert';

import '../utils/request_creator.dart';
import '../constants/app_constants/urls.dart';
import 'package:http/http.dart' as http;

import '../models/token.dart';
import '../models/user.dart';

class AuthService {
  static AuthService instance = AuthService._ctor();
  AuthService._ctor();

  Future<User?> login({required String email, required String password}) async {
    http.Request request = createRequest(
      endPoint: RestAPIPoints.login,
      bodyFields: {'email': email, 'password': password},
    );

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var result = json.decode(jsonString);
      User user = User.fromJson(result);
      return user;
    } else if (response.statusCode == 401) {
      User user = User(user: null, tokens: null);
      return user;
    }
    return null;
  }

  Future<User?> register(
      {required String name,
      required String email,
      required String password}) async {
    http.Request request = createRequest(
      endPoint: RestAPIPoints.register,
      bodyFields: {'name': name, 'email': email, 'password': password},
    );

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    // Created
    if (response.statusCode == 201) {
      var result = json.decode(jsonString);
      User user = User.fromJson(result);
      return user;
    }
    // Email already Taken
    else if (response.statusCode == 400) {
      User user = User(user: null, tokens: null);
      return user;
    }

    return null;
  }

  Future<bool> logout({required String refreshToken}) async {
    http.Request request = createRequest(
      endPoint: RestAPIPoints.logout,
      bodyFields: {'refreshToken': refreshToken},
    );

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 204) {
      // Sucsess
      return true;
    }
    return false;
  }

  Future<Tokens?> refreshAcsessToken({required String refreshToken}) async {
    http.Request request = createRequest(
      endPoint: RestAPIPoints.refresh,
      bodyFields: {'refreshToken': refreshToken},
    );

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    // Sucsess
    if (response.statusCode == 200) {
      var result = json.decode(jsonString);
      Tokens user = Tokens.fromJson(result);
      return user;
    }
    throw Exception(
        "[ERROR][AuthService][refreshAcsessToken] ${response.stream.bytesToString()}");
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

  Future<void> forgotSendMail(String email) async {
    http.Request request = createRequest(
      endPoint: RestAPIPoints.forgotPassword,
      bodyFields: {'email': email},
    );

    http.StreamedResponse response = await request.send();
    if (!(response.statusCode == 204)) {
      throw Exception(
          "[ERROR][AuthService][forgotSendMail] ${response.stream.bytesToString()}");
    }
    // Sucsess
  }

  Future<void> resetPassword(
      {required String email,
      required String password,
      required String code}) async {
    http.Request request = createRequest(
      endPoint: RestAPIPoints.resetPassword,
      bodyFields: {
        'email': email,
        'password': password,
        'code': code,
      },
    );

    http.StreamedResponse response = await request.send();

    if (!(response.statusCode == 204)) {
      throw Exception(
          "[ERROR][AuthService][resetPassword] ${response.stream.bytesToString()}");
    }
    // Sucsess
  }
}
