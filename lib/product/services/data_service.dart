import 'package:anket/product/models/category_model.dart';
import 'package:anket/product/models/survey.dart';
import 'package:anket/product/models/token.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DataService {
  static final DataService instance = DataService._ctor();

  DataService._ctor();
  static const String baseURL = "socialsurveyapp.software";

  /// [control] Checks if the user is logged in
  ///
  /// [token] Bearer cccess token
  Future<List<CategoryModel>> getCategories({
    required bool? control,
    required Tokens token,
  }) async {
    bool res = await AuthService.instance
        .refreshOrLogout(control: control, refreshToken: token.refresh.token);

    if (!res) {
      return [];
    }

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token.access.token}',
    };

    Uri uri = Uri.https(baseURL, '/api/v1/survey/categories');

    var request = http.Request('GET', uri);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(jsonString);
      List<CategoryModel> categories = List<CategoryModel>.from(
          jsonResponse.map((item) => CategoryModel.fromJson(item)).toList());
      return categories;
    } else {}
    return [];
  }

  /// [control] Checks if the user is logged in
  ///
  /// [token] Bearer cccess token
  ///
  /// [categoryId] categoryId (objectId)
  ///
  /// [sortBy] sort by query in the form of field:desc/asc (ex. name:asc)
  ///
  /// [name] Survey Name
  ///
  /// [searchForName] Enable regex search for name instead of exact match. Default is false
  ///
  /// [limit] Maximum number of surveys
  ///
  /// [page] Page number
  Future<List<Survey>> getSurveys({
    required bool? control,
    required Tokens token,
    String? categoryId,
    String? sortBy,
    String? name,
    bool? searchForName,
    int limit = 5,
    int page = 1,
  }) async {
    bool res = await AuthService.instance
        .refreshOrLogout(control: control, refreshToken: token.refresh.token);

    if (!res) {
      return [];
    }
    Map<String, dynamic> queryParameters = {
      'categoryId': categoryId,
      'sortBy': sortBy,
      'name': name,
      'searchForName': searchForName != null ? '$searchForName' : null,
      'limit': '$limit',
      'page': '$page',
    };
    queryParameters.removeWhere((key, value) => value == null);

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token.access.token}',
    };

    Uri uri = Uri.https(baseURL, '/api/v1/survey', queryParameters);
    
    var request = http.Request('GET', uri);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(jsonString);
      List<Survey> surveys = List<Survey>.from(
          jsonResponse['results'].map((item) => Survey.fromJson(item)).toList());
      return surveys;
    } else {}
    return [];
  }
}
