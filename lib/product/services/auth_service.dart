import 'dart:convert';
import 'package:anket/core/src/cache_manager.dart';
import 'package:anket/product/constants/app_constants/hive_model_constants.dart';
import 'package:anket/product/models/token.dart';
import 'package:anket/product/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final ModelCacheManager? manager;
  AuthService(this.manager);

  static const String baseURL = "https://www.socialsurveyapp.software/api/v1";

  // https://fd7a1991-8d21-499f-aa7b-231db6c4d466.mock.pstmn.io//auth/register
  static Future<UserModel?> login(
      {required String email, required String password}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse('$baseURL/auth/login'));
    request.bodyFields = {'email': email, 'password': password};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    print(jsonString);
    if (response.statusCode == 200) {
      var result = json.decode(jsonString);
      UserModel user = UserModel.fromJson(result);
      return user;
    } else if (response.statusCode == 401) {
      UserModel user = UserModel(user: null, tokens: null);
      return user;
    }
    // print(response.reasonPhrase);
    // throw Exception(response.reasonPhrase);
    return null;
  }

  static Future<UserModel?> register(
      {required String name,
      required String email,
      required String password}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse('$baseURL/auth/register'));
    request.bodyFields = {'name': name, 'email': email, 'password': password};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    print(jsonString);
    // Created
    if (response.statusCode == 201) {
      var result = json.decode(jsonString);
      UserModel user = UserModel.fromJson(result);
      return user;
    }
    // Taken
    else if (response.statusCode == 400) {
      UserModel user = UserModel(user: null, tokens: null);
      return user;
    }
    // print(response.reasonPhrase);
    // throw Exception(response.reasonPhrase);
    return null;
  }

  Future<Tokens?> refreshAcsessToken() async {
    Tokens token = manager!.getItem(HiveModelConstants.tokenKey);
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse('$baseURL/auth/register'));
    request.bodyFields = {'refreshToken': token.refresh.token};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    print(jsonString);
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
}
