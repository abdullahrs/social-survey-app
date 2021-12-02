import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/components/custom_button.dart';
import 'package:anket/product/view/entry/components/custom_text_field.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import 'sign_up_page.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Center(
                    child: Text('login', style: context.appTextTheme.headline2)
                        .tr()),
                const SizedBox(height: 50),
                CustomTextField(
                    prefixIconData: Icons.mail,
                    hintText: 'mail',
                    controller: _mailController),
                const SizedBox(height: 20),
                CustomTextField(
                    prefixIconData: Icons.lock,
                    hintText: 'password',
                    obscure: true,
                    controller: _passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        // TODO: change
                        child: const Text(
                          'forgot_pass',
                          style: TextStyle(color: Color(0xFF5a7061)),
                        ).tr())),
                const SizedBox(height: 50),
                CustomButton(
                  voidCallback: () {},
                  text: 'login',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('dont_have', style: context.appTextTheme.bodyText2)
                        .tr(),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignUpPage()));
                        },
                        child: const Text(
                          'register',
                          style: TextStyle(color: Color(0xFF5a7061)),
                        ).tr()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
