import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/components/custom_button.dart';
import 'package:anket/product/components/sign_up_text_button.dart';
import 'package:anket/product/constants/enums/auth_statuses.dart';
import 'package:anket/product/constants/style/colors.dart';
import 'package:anket/product/utils/text_field_validations.dart';
import 'package:anket/product/utils/token_cache_manager.dart';
import 'package:anket/product/view/entry/components/custom_text_field.dart';
import 'package:anket/product/view/entry/view_model/sign_in_cubit.dart';
import 'package:anket/product/view/home/pages/home.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_page.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TokenCacheManager userStatus = TokenCacheManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SignInCubit(
            mailController: _mailController,
            passwordController: _passwordController,
            formKey: _formKey,
            cacheManager: userStatus),
        child: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInValidationState && !state.isValidate) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Home()),
                  (_) => false);
            }
          },
          builder: (context, state) {
            return body(context, state);
          },
        ),
      ),
    );
  }

  Form body(BuildContext context, SignInState state) {
    return Form(
      key: _formKey,
      autovalidateMode: state is SignInValidationState
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
              SizedBox(height: context.dynamicHeight(0.1)),
              Center(
                  child: Text('login', style: context.appTextTheme.headline2)
                      .tr()),
              SizedBox(height: context.dynamicHeight(0.05)),
              mailField(),
              SizedBox(height: context.dynamicHeight(0.02)),
              passwordField(),
              forgotPassField(context),
              SizedBox(height: context.dynamicHeight(0.05)),
              Visibility(
                visible: state is SignInStatus
                    ? (state.status == AuthStatuses.unsucsess ? true : false)
                    : false,
                child: warningField(),
              ),
              CustomButton(
                voidCallback: () async =>
                    await context.read<SignInCubit>().postUserModel(),
                text: 'login',
                loading: state is SignInStatus
                    ? (state.status == AuthStatuses.started ? true : false)
                    : false,
              ),
              SizedBox(height: context.dynamicHeight(0.02)),
              const SentenceTextButton(
                text: 'dont_have',
                routeName: 'register',
              ),
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
        validator: (String? str) => getValidator(str, ValidationType.email));
  }

  CustomTextField passwordField() {
    return CustomTextField(
      prefixIconData: Icons.lock,
      hintText: 'password',
      obscure: true,
      controller: _passwordController,
      validator: (String? str) => getValidator(str, ValidationType.password),
    );
  }

  Align forgotPassField(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ForgotPassPage())),
            child: Text(
              'forgot_pass'.tr() + "?",
              style: const TextStyle(color: AppStyle.textButtonColor),
            )));
  }
}
