import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/constants/style/colors.dart';
import 'package:anket/product/view/entry/pages/sign_in_page.dart';
import 'package:anket/product/view/entry/pages/sign_up_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class SentenceTextButton extends StatelessWidget {
  final String text;
  final String routeName;
  const SentenceTextButton(
      {Key? key, required this.text, required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: context.appTextTheme.bodyText2).tr(),
        InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          routeName == 'login' ? SignInPage() : SignUpPage()));
            },
            child: Text(
              routeName,
              style: const TextStyle(color: AppStyle.textButtonColor),
            ).tr()),
      ],
    );
  }
}
