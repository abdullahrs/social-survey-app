import 'dart:async';
import '../view/entry/pages/forgot_password_page.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class ForgotPassUtil {
  static ForgotPassUtil instance = ForgotPassUtil._ctor();
  ForgotPassUtil._ctor();

  static late StreamSubscription sub;
  static BuildContext? context;
  static String? _openAppLink;

  String? get appLink => _openAppLink;

  Future<void> initUtil(BuildContext buildContext) async =>
      context = buildContext;

  Future<void> initUniLinks() async {
    try {
      final String? initialLink = await getInitialLink();
      if (initialLink != null) {
        _openAppLink = initialLink;
      }
    } catch (e) {
      // Error
    }
    sub = linkStream.listen((String? link) {
      _openAppLink = link;
      print("[URI] $link");
      if (_openAppLink != null) {
        Navigator.push(
          context!,
          MaterialPageRoute(
            builder: (context) => const ForgotPassPage(navigateToReset: true),
          ),
        );
      }
    }, onError: (err) {
      print("[ERROR][URI] $err");
    });
  }

  void dispose() => sub.cancel();
}
