import 'package:http/http.dart';

import '../../product/constants/enums/request_info.dart';
import '../../product/models/token.dart';
import 'cache_manager.dart';

abstract class ApiServiceManager {
  final String _tokenKey;
  final String _baseURL;
  final ModelCacheManager _cacheManager;

  ApiServiceManager(
      {required String tokenKey,
      required String baseURL,
      required ModelCacheManager modelCacheManager})
      : _tokenKey = tokenKey,
        _cacheManager = modelCacheManager,
        _baseURL = baseURL;

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
        _cacheManager.getItem(_tokenKey); // HiveModelConstants.tokenKey
    Map<String, String> headers = {
      'Content-Type':
          'application/${client == RequestClient.data ? "json" : "x-www-form-urlencoded"}', // "x-www-form-urlencoded"
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

    try {
      StreamedResponse streamedResponse = await request.send();
      Response response = await Response.fromStream(streamedResponse);
      if (response.statusCode == 401) {
        // TODO:
      }
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
