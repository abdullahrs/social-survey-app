import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/view/entry/pages/sign_up_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class SignUpTextButton extends StatelessWidget {
  const SignUpTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('dont_have', style: context.appTextTheme.bodyText2).tr(),
        InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => SignUpPage()));
            },
            child: const Text(
              'register',
              style: TextStyle(color: Color(0xFF5a7061)),
            ).tr()),
      ],
    );
  }
}
