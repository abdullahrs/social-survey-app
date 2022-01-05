import '../models/category.dart';
import '../../core/src/cache_manager.dart';
import '../constants/app_constants/hive_model_constants.dart';
import '../constants/app_constants/hive_type_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    _categories = cats;
    await putItem(HiveModelConstants.surveyCategoriesKey, _categories);
  }

  static List<String>? _submittedSurveys;

  List<String> get submittedSurveys => _submittedSurveys ?? [];

  Future<void> setSubmittedSurveys(List<String> surveyIds) async {
    _submittedSurveys = surveyIds;
  }

  Future<void> submitSurvey(String surveyId) async {
    _submittedSurveys ??= [];
    _submittedSurveys!.add(surveyId);
    await putItem(HiveModelConstants.submittedSurveysKey, _submittedSurveys);
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.categoriesTypeID)) {
      Hive.registerAdapter(CategoryAdapter());
    }
  }
}