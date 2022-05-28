import 'dart:convert';
import 'dart:developer';
import '../../product/utils/custom_exception.dart';
import 'package:http/http.dart';

import '../../product/constants/enums/request_info.dart';
import '../../product/models/token.dart';
import 'cache_manager.dart';

abstract class ApiServiceManager {
  final String _tokenKey;
  final String _baseURL;
  final String _refreshURL;
  final ModelCacheManager cacheManager;

  ApiServiceManager(
      {required String tokenKey,
      required String baseURL,
      required ModelCacheManager modelCacheManager,
      required String refreshURL})
      : _tokenKey = tokenKey,
        cacheManager = modelCacheManager,
        _baseURL = baseURL,
        _refreshURL = refreshURL;

  Future<Response> createRequestAndSend({
    RequestClient client = RequestClient.data,
    required String endPoint,
    Map<String, String>? bodyFields,
    String? body,
    Map<String, dynamic>? queryParams,
    required RequestType method,
    bool bearerActive = false,
  }) async {
    Tokens? token =
        cacheManager.getItem(_tokenKey); // HiveModelConstants.tokenKey
    Map<String, String> headers = {
      'Content-Type':
          'application/${client == RequestClient.data ? "json" : "x-www-form-urlencoded"}', // client == RequestClient.data ? "json" : "x-www-form-urlencoded"
    };

    if (bearerActive) {
      headers['Authorization'] = 'Bearer ${token!.access.token}';
    }

    Uri uri;

    if (queryParams != null) {
      uri = Uri.https(_baseURL, endPoint, queryParams);
    } else {
      uri = Uri.https(_baseURL, endPoint);
    }

    Request request = Request(method.name, uri);
    if (bodyFields != null) {
      request.bodyFields = bodyFields;
    }
    if (body != null) {
      request.body = body;
    }
    request.headers.addAll(headers);
    // log("Endpoint: $_baseURL$endPoint");
    // log("REQUEST METHOD : ${request.method}\n\nREQUEST HEADERS : ${request.headers}\n\nREQUEST BODY : ${request.body}");

    try {
      StreamedResponse streamedResponse = await request.send();
      Response response = await Response.fromStream(streamedResponse);
      // log("RESPONSE BODY ${response.body}");
      if (response.statusCode == 401) {
        bool control = await refreshToken();
        if (control) {
          return await createRequestAndSend(
              endPoint: endPoint,
              method: method,
              client: client,
              bodyFields: bodyFields,
              body: body,
              queryParams: queryParams,
              bearerActive: bearerActive);
        }
        throw FetchDataException(message: response.body, statusCode: 401);
      }
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> refreshToken() async {
    Tokens? token = cacheManager.getItem(_tokenKey);
    try {
      Response response = await createRequestAndSend(
          endPoint: _refreshURL,
          method: RequestType.POST,
          client: RequestClient.auth,
          bodyFields: {'refreshToken': token!.refresh.token});
      if (response.statusCode == 200) {
        var result = json.decode(utf8.decode(response.bodyBytes));
        Tokens newToken = Tokens.fromJson(result);
        await cacheManager.putItem(_tokenKey, newToken);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }
}
