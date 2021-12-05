import 'package:anket/product/models/user.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('[Test] Sign-up', () async{
    var result = await AuthService.register(email: "a@x.com", password: "asdasd", name: 'asd');
    expect(result.runtimeType, UserModel);
  });
  test('[Test] Log-in', () async{
    var result = await AuthService.login(email: "a@x.com", password: "asdasd");
    expect(result.runtimeType, UserModel);
  });

  test('[Test] Log-out', () {
  });

  test('[Test] Forgot Password', () {
  });

  test('[Test] Get survey categories', () {
  });

  test('[Test] Get popular surveys', () {
  });

  test('[Test] Get surveys participated in', () {
  });

  test('[Test] Get searched surveys', () {
  });

  test('[Test] Post survey', () {
  });

  test('[Test] Get survey results', () {
  });
}