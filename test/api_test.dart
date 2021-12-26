import 'package:anket/product/models/category_model.dart';
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
  test('[Test] Sign-up', () async {
    var result = await AuthService.instance.register(
        email: "xy@xy.com", password: "deneme1**", name: 'Deneme Deneme');
    expect(result.runtimeType, UserModel);
  });
  test('[Test] Log-in', () async {
    var result = await AuthService.instance
        .login(email: "deneme@x.com", password: "deneme1*");
    expect(result.runtimeType, UserModel);
  });

  test('[Test] Log-out', () async {
    var result = await AuthService.instance
        .login(email: "deneme@x.com", password: "deneme1*");
    bool? logoutResult = await AuthService.instance
        .logout(refreshToken: result!.tokens!.refresh.token);
    expect(logoutResult, true);
  });

  test('[Test] Forgot Password', () async {
    String? result = await AuthService.instance.forgotSendMail("deneme@x.com");
    expect(result, isNot(result == null));
    if(result != null){
      
    }
  });

  test('[Test] Get survey categories', () async {
    var result =
        await DataService.instance.getCategories(control: true, token: token);
    expect(result is List<CategoryModel>, true);
  });

  test('[Test] Get popular surveys', () {});

  test('[Test] Get surveys participated in', () {});

  test('[Test] Get searched surveys', () {});

  test('[Test] Post survey', () {});

  test('[Test] Get survey results', () {});
}
