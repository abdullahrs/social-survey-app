import 'package:http/http.dart';

import '../constants/app_constants/urls.dart';
import 'token_cache_manager.dart';

enum RequestClient { auth, data }

Future<Response> createRequestAndSend({
  RequestClient client = RequestClient.data,
  required String endPoint,
  Map<String, String>? bodyFields,
  String? body,
  Map<String, dynamic>? queryParams,
  String method = 'POST',
  bool bearerActive = false,

  /// Test ederken TokenCacheManager'den dolayi hata almamak icin
  String? testRefreshToken,
}) async {
  Map<String, String> headers = {
    'Content-Type':
        'application/${client == RequestClient.data ? "json" : "x-www-form-urlencoded"}', // "x-www-form-urlencoded"
  };

  if (bearerActive) {
    headers['Authorization'] =
        'Bearer ${testRefreshToken ?? TokenCacheManager().getToken()!.access.token}';
  }

  Uri uri;

  if (queryParams != null) {
    uri = Uri.https(RestAPIPoints.baseURL, endPoint, queryParams);
  } else {
    uri = Uri.https(RestAPIPoints.baseURL, endPoint);
  }

  Request request = Request(method, uri);
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
    return response;
  } catch (e) {
    throw Exception(e);
  }
}
