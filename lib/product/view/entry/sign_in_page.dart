import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/components/custom_button.dart';
import 'package:anket/product/constants/enums/login_statuses.dart';
import 'package:anket/product/view/entry/components/custom_text_field.dart';
import 'package:anket/product/view/entry/view_model/sign_in_cubit.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_page.dart';

class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) =>
            LoginCubit(_mailController, _passwordController, _formKey),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginValidationState && !state.isValidate) {
              // TODO: navigate to main menu
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => SignUpPage()));
            }
          },
          builder: (context, state) {
            return body(context, state);
          },
        ),
      ),
    );
  }

  Form body(BuildContext context, LoginState state) {
    return Form(
      key: _formKey,
      autovalidateMode: state is LoginValidationState
          ? (state.isValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled)
          : AutovalidateMode.disabled,
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
              mailField(),
              const SizedBox(height: 20),
              passwordField(),
              forgotPassField(),
              const SizedBox(height: 50),
              Visibility(
                visible: state is LoginStatus
                    ? (state.status == LoginStatuses.unsucsess ? true : false)
                    : false,
                child: warningField(),
              ),
              CustomButton(
                voidCallback: () async =>
                    await context.read<LoginCubit>().postUserModel(),
                text: 'login',
                loading: state is LoginStatus
                    ? (state.status == LoginStatuses.started ? true : false)
                    : false,
              ),
              const SizedBox(height: 20),
              signUpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding warningField() {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.close_outlined, color: Colors.red),
                    const Text(
                      'wrong_morp',
                      style: TextStyle(color: Colors.red),
                    ).tr(),
                  ],
                ),
              );
  }

  CustomTextField mailField() {
    return CustomTextField(
      prefixIconData: Icons.mail,
      hintText: 'mail',
      controller: _mailController,
      validator: (String? str) {
        if (str == null || str.isEmpty) return "empty_field".tr();
        return !str.contains("@") || !str.contains(".com")
            ? 'unvalid_email'.tr()
            : null;
      },
      // TODO: (String? str) => getValidator(str),
    );
  }

  CustomTextField passwordField() {
    return CustomTextField(
      prefixIconData: Icons.lock,
      hintText: 'password',
      obscure: true,
      controller: _passwordController,
      validator: (String? str) {
        if (str == null || str.isEmpty) return "empty_field".tr();
        return str.length < 6 ? 'short_password'.tr() : null;
      },
    );
  }

  Align forgotPassField() {
    return Align(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {},
            // TODO: change
            child: const Text(
              'forgot_pass',
              style: TextStyle(color: Color(0xFF5a7061)),
            ).tr()));
  }

  Row signUpButton(BuildContext context) {
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
