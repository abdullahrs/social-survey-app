import 'package:http/http.dart';

import '../constants/app_constants/urls.dart';
import '../models/token.dart';

Request createRequest({
    Tokens? token,
    required String endPoint,
    required Map<String, String> bodyFields,
    String method = 'POST',
    bool bearerActive = false,
  }) {
    Map<String, String> headers = {
     'Content-Type': 'application/x-www-form-urlencoded',
    };

    if (bearerActive && token != null) {
      headers['Authorization'] = 'Bearer ${token.access.token}';
    }

    Uri uri = Uri.https(RestAPIPoints.baseURL, endPoint);

    Request request = Request(method, uri);

    request.bodyFields = bodyFields;
    request.headers.addAll(headers);

    return request;
  }