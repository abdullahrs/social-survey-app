import 'package:auto_route/src/router/auto_router_x.dart';

import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';
import 'package:flutter/material.dart';

class InitializeValues {
  late BuildContext context;

  Future<bool> setup(BuildContext context) async {
    try {
      await init();
      context.router.replaceNamed('home');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> init() async {
    var data = await DataService.instance.getCategories();
    await SurveyCacheManager.instance.setCategories(data);
    var submits = await DataService.instance
        .getSubmits(userID: SurveyCacheManager.instance.userID);
    if (submits != null) {
      await SurveyCacheManager.instance.setSubmittedSurveys(submits);
    }
  }
}
