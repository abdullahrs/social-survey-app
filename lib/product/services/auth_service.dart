import 'dart:convert';

import '../constants/enums/request_info.dart';
import '../../core/src/api_service_manager.dart';
import '../../core/src/cache_manager.dart';

import '../utils/custom_exception.dart';
import 'package:http/http.dart' as http;

import '../constants/app_constants/urls.dart';
import '../models/token.dart';
import '../models/user.dart';

class AuthService extends ApiServiceManager {
  AuthService(
      {required String tokenKey,
      required String baseURL,
      required ModelCacheManager manager})
      : super(tokenKey: tokenKey, baseURL: baseURL, modelCacheManager: manager);

  static AuthService? _instance;

  factory AuthService.fromCache(
      {String? tokenKey, String? baseURL, ModelCacheManager? manager}) {
    if (_instance == null) {
      if (tokenKey != null && baseURL != null && manager != null) {
        _instance =
            AuthService(tokenKey: tokenKey, baseURL: baseURL, manager: manager);
        return _instance!;
      }
      throw Exception(
          "[ERROR][AuthService.fromCache] The instance is null, you must fill all of the optional parameters");
    }
    return _instance!;
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      http.Response response = await createRequestAndSend(
          endPoint: RestAPIPoints.login,
          bodyFields: {'email': email, 'password': password},
          client: RequestClient.auth,
          method: RequestType.POST);

      if (response.statusCode == 200) {
        var result = json.decode(utf8.decode(response.bodyBytes));
        User user = User.fromJson(result);
        return user;
      } else if (response.statusCode == 401) {
        User user = User(user: null, tokens: null);
        return user;
      }
    } catch (e) {
      return null;
    }
  }

  Future<User?> register(
      {required String name,
      required String email,
      required String password}) async {
    http.Response response = await createRequestAndSend(
        endPoint: RestAPIPoints.register,
        bodyFields: {'name': name, 'email': email, 'password': password},
        client: RequestClient.auth,
        method: RequestType.POST);

    // Created
    if (response.statusCode == 201) {
      var result = json.decode(utf8.decode(response.bodyBytes));
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

  Future<bool> updateUser(
      {required String userID,
      required String gender,
      required String date,
      required String refreshToken}) async {
    http.Response response = await createRequestAndSend(
        endPoint: RestAPIPoints.updateUser + '/' + userID,
        bodyFields: {'refreshToken': refreshToken},
        method: RequestType.PATCH,
        client: RequestClient.auth);
    if (response.statusCode == 200) {
      // Sucsess
      return true;
    }
    return false;
  }

  Future<bool> logout({required String refreshToken}) async {
    http.Response response = await createRequestAndSend(
        endPoint: RestAPIPoints.logout,
        bodyFields: {'refreshToken': refreshToken},
        client: RequestClient.auth,
        method: RequestType.POST);
    if (response.statusCode == 204) {
      // Sucsess
      return true;
    }
    return false;
  }

  Future<Tokens?> refreshAcsessToken({required String refreshToken}) async {
    http.Response response = await createRequestAndSend(
        endPoint: RestAPIPoints.refresh,
        bodyFields: {'refreshToken': refreshToken},
        client: RequestClient.auth,
        method: RequestType.POST);

    // Sucsess
    if (response.statusCode == 200) {
      var result = json.decode(utf8.decode(response.bodyBytes));
      Tokens user = Tokens.fromJson(result);
      return user;
    }
    throw FetchDataException(
        statusCode: response.statusCode, message: response.body);
  }

  Future<void> forgotSendMail(String email) async {
    http.Response response = await createRequestAndSend(
        endPoint: RestAPIPoints.forgotPassword,
        bodyFields: {'email': email},
        client: RequestClient.auth,
        method: RequestType.POST);

    if (!(response.statusCode == 204)) {
      throw FetchDataException(
          statusCode: response.statusCode, message: response.body);
    }
    // Sucsess
  }

  Future<void> resetPassword(
      {required String email,
      required String password,
      required String code}) async {
    http.Response response = await createRequestAndSend(
        endPoint: RestAPIPoints.resetPassword,
        bodyFields: {
          'email': email,
          'password': password,
          'code': code,
        },
        client: RequestClient.auth,
        method: RequestType.POST);
    if (!(response.statusCode == 204)) {
      throw FetchDataException(
          statusCode: response.statusCode, message: response.body);
    }
    // Sucsess
  }
}
