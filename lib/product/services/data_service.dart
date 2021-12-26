import 'package:anket/product/models/category_model.dart';
import 'package:anket/product/models/token.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DataService {
  static final DataService instance = DataService._ctor();

  DataService._ctor();

  static const String baseURL = "https://socialsurveyapp.software/api/v1";

  Future<List<CategoryModel>> getCategories(
      {required bool? control, required Tokens token}) async {
    // bool? control = (modelCacheManager as TokenCacheManager).checkUserIsLogin();
    // Tokens token = modelCacheManager.getItem(HiveModelConstants.tokenKey)!;

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
    var request = http.Request('GET', Uri.parse('$baseURL/survey/categories'));
    // request.bodyFields = {'accessToken': token.access.token};
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
}
