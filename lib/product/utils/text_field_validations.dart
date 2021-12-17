import 'package:easy_localization/src/public_ext.dart';

enum ValidationType { name, email, password, repeatPassword }

String? getValidator(String? str, ValidationType type, {String? firstStr}) {
  switch (type) {
    case ValidationType.name:
      if (str == null || str.isEmpty) return "empty_field".tr();
      return null;
    case ValidationType.email:
      if (str == null || str.isEmpty) return "empty_field".tr();
      return !str.contains("@") || !str.contains(".com")
          ? 'unvalid_email'.tr()
          : null;
    case ValidationType.password:
      {
        if (str == null || str.isEmpty) return "empty_field".tr();
        RegExp digitExp = RegExp(r'\d+');
        RegExp specialExp = RegExp(r'[^A-Za-z0-9]');
        if(!digitExp.hasMatch(str) || !specialExp.hasMatch(str)) return 'password_lacking'.tr();
        return str.length < 6 ? 'short_password'.tr() : null;
      }
    case ValidationType.repeatPassword:
      if (str == null || str.isEmpty) return "empty_field".tr();
      if (str != firstStr) {
        return "unmatch_password".tr();
      }
      return str.length < 6 ? 'short_password'.tr() : null;
    default:
      return null;
  }
}
