import '../models/token.dart';
import '../services/auth_service.dart';
import 'custom_exception.dart';
import 'package:http/http.dart';

import '../constants/app_constants/urls.dart';
import 'token_cache_manager.dart';

enum RequestClient { auth, data }
// ignore: constant_identifier_names
enum RequestType {GET, POST, UPDATE, PATCH}

Future<Response> createRequestAndSend({
  RequestClient client = RequestClient.data,
  required String endPoint,
  Map<String, String>? bodyFields,
  String? body,
  Map<String, dynamic>? queryParams,
  required RequestType method,
  bool bearerActive = false,
}) async {
  TokenCacheManager manager = TokenCacheManager();
  Tokens? token = manager.getToken();
  Map<String, String> headers = {
    'Content-Type':
        'application/${client == RequestClient.data ? "json" : "x-www-form-urlencoded"}', // "x-www-form-urlencoded"
  };

  if (bearerActive) {
    headers['Authorization'] =
        'Bearer ${token!.access.token}';
  }

  Uri uri;

  if (queryParams != null) {
    uri = Uri.https(RestAPIPoints.baseURL, endPoint, queryParams);
  } else {
    uri = Uri.https(RestAPIPoints.baseURL, endPoint);
  }

  Request request = Request(method.name, uri);
  if (bodyFields != null) {
    request.bodyFields = bodyFields;
  }
  if (body != null) {
    request.body = body;
  }
  request.headers.addAll(headers);

  try {
    StreamedResponse streamedResponse = await request.send();
    Response response = await Response.fromStream(streamedResponse);
    if (response.statusCode == 401) {
      bool? control = manager.checkUserIsLogin(token);
      if (control != null && !control) {
        await AuthService.instance
            .refreshAcsessToken(refreshToken: token!.refresh.token);
        throw FetchDataException(message: response.body, statusCode: 401);
      }
      throw FetchDataException(
          message: response.body, statusCode: response.statusCode);
    }
    return response;
  } catch (e) {
    throw Exception(e);
  }
}
