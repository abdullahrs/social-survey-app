import 'dart:convert' as convert;

import '../utils/request_creator.dart';

import '../constants/app_constants/urls.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/survey.dart';
import '../models/token.dart';
import '../models/post.dart';
import 'auth_service.dart';

class DataService {
  static final DataService instance = DataService._ctor();

  DataService._ctor();

  /// Creates http request from given end point and http method

  /// [control] Checks if the user is logged in
  ///
  /// [token] Bearer cccess token
  Future<List<Category>> getCategories({
    required bool? control,
    required Tokens token,
  }) async {
    bool res = await AuthService.instance
        .refreshOrLogout(control: control, refreshToken: token.refresh.token);

    if (!res) {
      return [];
    }
    http.Request request = createRequest(
        token: token,
        endPoint: RestAPIPoints.categories,
        bodyFields: {},
        method: 'GET',
        bearerActive: true);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(jsonString);
      List<Category> categories = List<Category>.from(
          jsonResponse.map((item) => Category.fromJson(item)).toList());
      return categories;
    } else {}
    return [];
  }

  /// [control] Checks if the user is logged in
  ///
  /// [token] Bearer access token
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

    Uri uri =
        Uri.https(RestAPIPoints.baseURL, RestAPIPoints.survey, queryParameters);

    var request = http.Request('GET', uri);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(jsonString);
      List<Survey> surveys = List<Survey>.from(jsonResponse['results']
          .map((item) => Survey.fromJson(item))
          .toList());
      return surveys;
    } else {}
    return [];
  }

  /// Returns List<int> [x,y]
  ///
  /// x: number of surveys, y: number of pages
  ///
  /// The default number of surveys per page is 10.
  Future<List<int>> getSurveyCountInfo({required Tokens token}) async {
    http.Request request = createRequest(
        token: token,
        endPoint: RestAPIPoints.survey,
        bodyFields: {},
        method: 'GET',
        bearerActive: true);

    http.StreamedResponse response = await request.send();

    String jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(jsonString);
      return [
        jsonResponse['totalResults'] as int,
        jsonResponse['totalPages'] as int
      ];
    }
    return [];
  }

  /// Submits the survey
  Future<bool> sendSurveyAnswers(
      {required Tokens token, required Post postModel}) async {
    http.Request request = createRequest(
        token: token,
        endPoint: RestAPIPoints.submitSurvey,
        bodyFields: {},
        bearerActive: true);
    request.body = convert.jsonEncode(postModel.toJson());
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) return true;
    return false;
  }
}
