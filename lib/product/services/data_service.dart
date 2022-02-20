import 'dart:convert' as convert;

import '../utils/custom_exception.dart';
import 'package:http/http.dart' as http;

import '../constants/app_constants/urls.dart';
import '../models/category.dart';
import '../models/post.dart';
import '../models/survey.dart';
import '../utils/request_creator.dart';

class DataService {
  static final DataService instance = DataService._ctor();

  DataService._ctor();

  Future<List<Category>> getCategories() async {
    http.Response response = await createRequestAndSend(
      endPoint: RestAPIPoints.categories,
      method: 'GET',
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
      method: 'GET',
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
      method: 'GET',
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
    );

    if (!(response.statusCode == 204)) {
      throw FetchDataException(
          statusCode: response.statusCode, message: response.body);
    }
  }

  Future<List<String>?> getSubmits(String userID) async {
    http.Response response = await createRequestAndSend(
      endPoint: RestAPIPoints.user + '/' + userID,
      method: 'GET',
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
