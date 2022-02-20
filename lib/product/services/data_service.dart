import 'dart:convert' as convert;

import '../constants/enums/request_info.dart';

import '../../core/src/api_service_manager.dart';
import '../../core/src/cache_manager.dart';

import '../utils/custom_exception.dart';
import 'package:http/http.dart' as http;

import '../constants/app_constants/urls.dart';
import '../models/category.dart';
import '../models/post.dart';
import '../models/survey.dart';

class DataService extends ApiServiceManager {
  DataService._ctor(
      {required String tokenKey,
      required String baseURL,
      required ModelCacheManager manager,
      required String refreshURL})
      : super(
            tokenKey: tokenKey,
            baseURL: baseURL,
            modelCacheManager: manager,
            refreshURL: refreshURL);

  static DataService? _instance;

  factory DataService.fromCache(
      {String? tokenKey,
      String? baseURL,
      ModelCacheManager? manager,
      String? refreshURL}) {
    if (_instance == null) {
      if (tokenKey != null && baseURL != null 
        && manager != null && refreshURL != null) {
        _instance = DataService._ctor(
            tokenKey: tokenKey,
            baseURL: baseURL,
            manager: manager,
            refreshURL: refreshURL);
        return _instance!;
      }
      throw Exception(
          "[ERROR][DataService.fromCache] The instance is null, you must fill all of the optional parameters");
    }
    return _instance!;
  }

  Future<List<Category>> getCategories() async {
    http.Response response = await createRequestAndSend(
      endPoint: RestAPIPoints.categories,
      method: RequestType.GET,
      bearerActive: true,
    );

    if (response.statusCode == 200) {
      var result = convert.json.decode(convert.utf8.decode(response.bodyBytes));
      List<Category> categories = List<Category>.from(
          result.map((item) => Category.fromJson(item)).toList());
      return categories;
    }
    throw FetchDataException(
        statusCode: response.statusCode, message: response.body);
  }

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
    String? categoryId,
    String? sortBy,
    String? name,
    bool? searchForName,
    int limit = 5,
    int page = 1,
  }) async {
    Map<String, dynamic> queryParameters = {
      'categoryId': categoryId,
      'sortBy': sortBy,
      'name': name,
      'searchForName': searchForName != null ? '$searchForName' : null,
      'limit': '$limit',
      'page': '$page',
    };
    queryParameters.removeWhere((key, value) => value == null);

    http.Response response = await createRequestAndSend(
      endPoint: RestAPIPoints.survey,
      method: RequestType.GET,
      bearerActive: true,
      queryParams: queryParameters,
    );

    if (response.statusCode == 200) {
      var result = convert.json.decode(convert.utf8.decode(response.bodyBytes));
      List<Survey> surveys = List<Survey>.from(
          result['results'].map((item) => Survey.fromJson(item)).toList());
      return surveys;
    }
    throw FetchDataException(
        statusCode: response.statusCode, message: response.body);
  }

  /// Returns List<int> [x,y]
  ///
  /// x: number of surveys, y: number of pages
  ///
  /// The default number of surveys per page is 10.
  Future<List<int>> getSurveyCountInfo() async {
    http.Response response = await createRequestAndSend(
      endPoint: RestAPIPoints.survey,
      method: RequestType.GET,
      bearerActive: true,
    );

    if (response.statusCode == 200) {
      var result = convert.json.decode(convert.utf8.decode(response.bodyBytes));
      return [result['totalResults'] as int, result['totalPages'] as int];
    }
    throw FetchDataException(
        statusCode: response.statusCode, message: response.body);
  }

  /// Submits the survey
  Future<void> sendSurveyAnswers(Post postModel) async {
    http.Response response = await createRequestAndSend(
        endPoint: RestAPIPoints.submitSurvey,
        body: convert.jsonEncode(postModel.toJson()),
        bearerActive: true,
        method: RequestType.POST);

    if (!(response.statusCode == 204)) {
      throw FetchDataException(
          statusCode: response.statusCode, message: response.body);
    }
  }

  Future<List<String>?> getSubmits(String userID) async {
    http.Response response = await createRequestAndSend(
      endPoint: RestAPIPoints.user + '/' + userID,
      method: RequestType.GET,
      bearerActive: true,
    );

    var result = convert.json.decode(convert.utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return List<String>.from(result['submittedSurveys'] ?? []);
    }
    throw FetchDataException(
        statusCode: response.statusCode, message: response.body);
  }
}
