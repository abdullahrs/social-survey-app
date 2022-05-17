
import 'dart:ui';

import '../constants/app_constants/hive_model_constants.dart';
import '../constants/app_constants/locals.dart';
import 'survey_cache_manager.dart';

class LangUtil{
  static Future<Locale?> setLang(String? l) async{
    if(l == null ) return null;
    await SurveyCacheManager.instance.putItem(HiveModelConstants.lang, l);
    return kSupportedLocales.firstWhere((element) => element.languageCode == l);
  }
}