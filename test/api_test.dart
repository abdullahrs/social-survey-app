import 'package:anket/product/models/token.dart';
import 'package:anket/product/models/user.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:anket/product/services/data_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Tokens token;
  setUp(() async {
    var result = await AuthService.instance
        .login(email: "deneme@x.com", password: "deneme1*");
    token = result!.tokens!;
  });

  group('Authentication tests', () {
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

    test('Forgot Password', () async {
      // String? result =
      //     await AuthService.instance.forgotSendMail("deneme@x.com");
      // expect(result, isNot(result == null));
      // if (result != null) {}
    });
  });

  group('Data service tests', () {
    test('Get survey categories', () async {
      var result =
          await DataService.instance.getCategories(control: true, token: token);
      expect(result.isNotEmpty, true);
    });

    test('Get surveys', () async {
      var result =
          await DataService.instance.getSurveys(control: true, token: token);
      expect(result.isNotEmpty, true);
    });

    test('Get surveys participated in', () {});

    test('Get searched surveys', () {});

    test('Post survey', () {});
  });
}
