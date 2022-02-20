import '../../../constants/app_constants/hive_model_constants.dart';
import '../../../constants/app_constants/urls.dart';
import '../../../services/auth_service.dart';
import '../../../utils/token_cache_manager.dart';

import '../../../utils/custom_exception.dart';
import 'package:auto_route/src/router/auto_router_x.dart';

import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';
import 'package:flutter/material.dart';

class InitializeValues {
  late BuildContext context;

  Future<bool> setup(BuildContext context) async {
    try {
      bool? result = await init();
      result ??= await init();
      if (result == null || !result) {
        return false;
      }
      context.router.replaceNamed('home');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> init() async {
    try {
      DataService _dataService = DataService.fromCache(
          tokenKey: HiveModelConstants.tokenKey,
          baseURL: RestAPIPoints.baseURL,
          manager: TokenCacheManager(),
          refreshURL: RestAPIPoints.refresh);
      AuthService.fromCache(
          tokenKey: HiveModelConstants.tokenKey,
          baseURL: RestAPIPoints.baseURL,
          manager: TokenCacheManager(),
          refreshURL: RestAPIPoints.refresh);
      var data = await _dataService.getCategories();
      await SurveyCacheManager.instance.setCategories(data);
      var submits =
          await _dataService.getSubmits(SurveyCacheManager.instance.userID);
      if (submits != null) {
        await SurveyCacheManager.instance.setSubmittedSurveys(submits);
      }
      return true;
    } catch (e) {
      if (e is FetchDataException && e.statusCode == 401) {
        return null;
      }
      return false;
    }
  }
}
