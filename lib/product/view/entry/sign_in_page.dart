import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/components/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
              textField(prefixIconData: Icons.mail, hintText: 'mail',),
              const SizedBox(height: 20),
              textField(prefixIconData: Icons.lock, hintText: 'password',obscure: true),
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
                  Text('dont_have', style: context.appTextTheme.bodyText2).tr(),
                  InkWell(
                      onTap: () {},
                      // TODO: change
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
    );
  }

  TextFormField textField({required IconData prefixIconData, required String hintText,bool obscure = false}) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIconData),
        hintText: hintText.tr(),
      ),
      obscureText: obscure,
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
