import 'package:anket/product/models/category.dart';
import 'package:anket/product/models/post.dart';
import 'package:anket/product/models/survey.dart';
import 'package:anket/product/models/token.dart';
import 'package:anket/product/models/user.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:anket/product/services/data_service.dart';
import 'package:anket/product/utils/custom_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Tokens token;
  late List<Survey> surveys;
  late List<Category> categories;

  setUp(() async {
    var result = await AuthService.instance
        .login(email: "abdullahrsimsek@gmail.com", password: "deneme1*");
    token = result!.tokens!;
  });

  group('[Authentication tests]', () {
    test('Sign-up', () async {
      var result = await AuthService.instance.register(
          email: "xy@xy.com", password: "deneme1**", name: 'Deneme Deneme');
      expect(result.runtimeType, User);
    });
    test('Log-in', () async {
      var result = await AuthService.instance
          .login(email: "deneme@x.com", password: "deneme1*");
      expect(result.runtimeType, User);
    });

    test('Log-out', () async {
      bool? logoutResult =
          await AuthService.instance.logout(refreshToken: token.refresh.token);
      expect(logoutResult, true);
    });

    test('Forgot Password', () async {});
  });

  group('[Data service tests]', () {
    test('Get survey categories', () async {
      categories = await DataService.instance.getCategories(
        testToken: token.access.token,
      );
      expect(categories.isNotEmpty, true);
    });

    test('Get surveys', () async {
      surveys =
          await DataService.instance.getSurveys(testToken: token.access.token);
      expect(surveys.isNotEmpty, true);
      expect(surveys.first.questions.isNotEmpty, true);
    });

    test('Search by exact match ', () async {
      var searchByExactMatch = await DataService.instance
          .getSurveys(name: surveys.first.name, testToken: token.access.token);
      expect(searchByExactMatch.length == 1, true);
    });

    test('Get survey count info', () async {
      var surveyCountInfo = await DataService.instance
          .getSurveyCountInfo(testToken: token.access.token);
      expect(surveyCountInfo.isNotEmpty, true);
    });

    test('Get survey by category id', () async {
      String categoryId = categories.first.id;
      var result = await DataService.instance
          .getSurveys(categoryId: categoryId, testToken: token.access.token);

      expect(result.first.categoryId == categoryId, true);
    });

    test('Search with regex', () async {
      String str = "question";
      var searchByName = await DataService.instance.getSurveys(
          name: str, searchForName: true, testToken: token.access.token);
      int count =
          surveys.where((e) => e.name.toLowerCase().contains(str)).length;
      expect(searchByName.length == count, true);
    });

    test('Get surveys with limit', () async {
      int limit = 3;
      var result = await DataService.instance
          .getSurveys(limit: limit, testToken: token.access.token);
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
      expect(
          () async => await DataService.instance.sendSurveyAnswers(
               postModel: post, testToken: token.access.token),
          throwsA(isA<FetchDataException>()));
    });
  });
}
