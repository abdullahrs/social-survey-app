import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import '../../core/src/cache_manager.dart';
import '../constants/app_constants/hive_model_constants.dart';
import '../constants/app_constants/hive_type_constants.dart';
import '../models/category.dart';

class SurveyCacheManager extends ModelCacheManager {
  SurveyCacheManager({String boxKey = HiveModelConstants.surveyStorageKey})
      : super(boxKey);

  /// Single instance
  static SurveyCacheManager? _instance;

  static SurveyCacheManager get instance {
    _instance ??= SurveyCacheManager();
    return _instance!;
  }

  static List<Category>? _categories;

  List<Category> get categories => _categories ?? <Category>[];

  Future<void> setCategories(List<Category> cats) async {
    _categories = [Category(id: "locationID", name: "location", color: "#FF8243", rank: 1)];
    _categories!.addAll(cats);
    await putItem(HiveModelConstants.surveyCategoriesKey, _categories);
  }

  static List<String>? _submittedSurveys;

  List<String> get submittedSurveys => _submittedSurveys ?? [];

  Future<void> setSubmittedSurveys(List<String> surveyIds) async {
    _submittedSurveys = surveyIds;
    await putItem(HiveModelConstants.submittedSurveysKey, _submittedSurveys);
  }

  Future<void> submitSurvey(String surveyId) async {
    _submittedSurveys ??= [];
    _submittedSurveys!.add(surveyId);
    await putItem(HiveModelConstants.submittedSurveysKey, _submittedSurveys);
  }

  String get userID => getItem(HiveModelConstants.userIDKey);
  Future<void> setUserID(String id) async =>
      putItem(HiveModelConstants.userIDKey, id);

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.categoriesTypeID)) {
      Hive.registerAdapter(CategoryAdapter());
    }
  }
}
