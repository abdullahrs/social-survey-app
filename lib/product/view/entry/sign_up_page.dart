import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/components/custom_button.dart';
import 'package:anket/product/view/entry/components/custom_text_field.dart';
import 'package:anket/product/view/entry/sign_in_page.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPassController = TextEditingController();
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
                  child: Text('register', style: context.appTextTheme.headline2)
                      .tr()),
              const SizedBox(height: 50),
              CustomTextField(
                  prefixIconData: Icons.person,
                  hintText: 'name',
                  controller: _nameController),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              CustomTextField(
                  prefixIconData: Icons.repeat,
                  hintText: 'password_repeat',
                  obscure: true,
                  controller: _repeatPassController),
              const SizedBox(height: 50),
              CustomButton(voidCallback: () {}, text: 'register'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('do_have', style: context.appTextTheme.bodyText2).tr(),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => SignInPage()));
                      },
                      // TODO: change
                      child: const Text(
                        'login',
                        style: TextStyle(color: Color(0xFF5a7061)),
                      ).tr()),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
