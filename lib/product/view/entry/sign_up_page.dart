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
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Center(
                    child:
                        Text('register', style: context.appTextTheme.headline2)
                            .tr()),
                const SizedBox(height: 50),
                nameField(),
                const SizedBox(height: 20),
                mailField(),
                const SizedBox(height: 20),
                passwordField(),
                const SizedBox(height: 20),
                repeatPasswordField(),
                const SizedBox(height: 50),
                CustomButton(voidCallback: () {}, text: 'register'),
                const SizedBox(height: 20),
                loginButton(context),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomTextField nameField() {
    return CustomTextField(
        prefixIconData: Icons.person,
        hintText: 'name',
        controller: _nameController,
        validator: (String? str) {
          if (str == null) return "empty_field".tr();
        });
  }

  CustomTextField mailField() {
    return CustomTextField(
      prefixIconData: Icons.mail,
      hintText: 'mail',
      controller: _mailController,
      validator: (String? str) {
        if (str == null) return "empty_field".tr();
        return !str.contains("@") || !str.contains(".com")
            ? 'unvalid_email'.tr()
            : null;
      },
    );
  }

  CustomTextField passwordField() {
    return CustomTextField(
        prefixIconData: Icons.lock,
        hintText: 'password',
        obscure: true,
        controller: _passwordController,
        validator: (String? str) {
          if (str == null) return "empty_field".tr();
          return str.length < 6 ? 'short_password'.tr() : null;
        });
  }

  CustomTextField repeatPasswordField() {
    return CustomTextField(
        prefixIconData: Icons.repeat,
        hintText: 'password_repeat',
        obscure: true,
        controller: _repeatPassController,
        validator: (String? str) {
          if (str == null) return "empty_field".tr();
          if (_passwordController.text != _repeatPassController.text) {
            return "unmatch_password".tr();
          }
          return str.length < 6 ? 'short_password'.tr() : null;
        });
  }

  Row loginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('do_have', style: context.appTextTheme.bodyText2).tr(),
        InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => SigninPage()));
            },
            // TODO: change
            child: const Text(
              'login',
              style: TextStyle(color: Color(0xFF5a7061)),
            ).tr()),
      ],
    );
  }
}
