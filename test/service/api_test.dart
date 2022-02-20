import 'package:anket/product/constants/app_constants/hive_model_constants.dart';
import 'package:anket/product/constants/app_constants/urls.dart';
import 'package:anket/product/models/category.dart';
import 'package:anket/product/models/post.dart';
import 'package:anket/product/models/survey.dart';
import 'package:anket/product/models/token.dart';
import 'package:anket/product/models/user.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:anket/product/services/data_service.dart';
import 'package:anket/product/utils/custom_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mock_token_cache_manager.dart';

void main() {
  late Tokens token;
  late List<Survey> surveys;
  late List<Category> categories;
  late DataService dataService;
  late AuthService authService;
  final MockTokenCacheManager mockTokenCacheManager = MockTokenCacheManager();

  setUp(() {
    dataService = DataService.fromCache(
        tokenKey: HiveModelConstants.tokenKey,
        baseURL: RestAPIPoints.baseURL,
        manager: mockTokenCacheManager);
    authService = AuthService.fromCache(
        tokenKey: HiveModelConstants.tokenKey,
        baseURL: RestAPIPoints.baseURL,
        manager: mockTokenCacheManager);
  });

  group('[Authentication tests]', () {
    test('Log-in', () async {
      var result = await authService.login(
          email: "abdullahrsimsek@gmail.com", password: "deneme1*");
      expect(result.runtimeType, User);
      if (result != null) token = result.tokens!;
    });

    test('Sign-up', () async {
      var result = await authService.register(
          email: "xyz@xy.com", password: "deneme1**", name: 'Deneme Deneme');
      expect(result.runtimeType, User);
    });
    test('Forgot Password', () async {});

    test('[Authentication tests] Log-out', () async {
      bool? logoutResult =
          await authService.logout(refreshToken: token.refresh.token);
      expect(logoutResult, true);
    });
  });

  group('[Data service tests]', () {
    test('Get survey categories', () async {
      categories = await dataService.getCategories();
      expect(categories.isNotEmpty, true);
    });

    test('Get surveys', () async {
      surveys = await dataService.getSurveys();
      expect(surveys.isNotEmpty, true);
      expect(surveys.first.questions.isNotEmpty, true);
    });

    test('Search by exact match ', () async {
      var searchByExactMatch =
          await dataService.getSurveys(name: surveys.first.name);
      expect(searchByExactMatch.length == 1, true);
    });

    test('Get survey count info', () async {
      var surveyCountInfo = await dataService.getSurveyCountInfo();
      expect(surveyCountInfo.isNotEmpty, true);
    });

    test('Get survey by category id', () async {
      String categoryId = categories.first.id;
      var result = await dataService.getSurveys(categoryId: categoryId);

      expect(result.first.categoryId == categoryId, true);
    });

    test('Search with regex', () async {
      String str = "question";
      var searchByName =
          await dataService.getSurveys(name: str, searchForName: true);
      int count =
          surveys.where((e) => e.name.toLowerCase().contains(str)).length;
      expect(searchByName.length == count, true);
    });

    test('Get surveys with limit', () async {
      int limit = 3;
      var result = await dataService.getSurveys(limit: limit);
      expect(result.length == 3, true);
    });

    test('Post survey', () async {
      Post post = Post(
          surveyId: surveys.first.id,
          location: UserLocation(lat: 24.3, long: 12.1),
          answers: [
            UserAnswer(
                questionId: surveys.first.questions.first.questionId,
                answerId: 1)
          ]);
      // Already submitted hatasi cikmali
      expect(() async => await dataService.sendSurveyAnswers(post),
          throwsA(isA<FetchDataException>()));
    });
  });
}
