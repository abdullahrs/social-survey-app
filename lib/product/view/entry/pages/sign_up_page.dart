import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../components/custom_button.dart';
import '../../../components/sign_up_text_button.dart';
import '../../../constants/enums/auth_statuses.dart';
import '../../../utils/text_field_validations.dart';
import '../../../utils/token_cache_manager.dart';
import '../components/custom_text_field.dart';
import '../view_model/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TokenCacheManager userStatus = TokenCacheManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterCubit(
          formKey: _formKey,
          nameController: _nameController,
          mailController: _mailController,
          passwordController: _passwordController,
          repeatPassController: _repeatPassController,
          cacheManager: userStatus,
        ),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) async {
            if (state is RegisterValidationState && state.registerValidation) {
              var data = await DataService.instance.getCategories(
                control: true,
                token: TokenCacheManager.instance.getToken()!,
              );
              await SurveyCacheManager.instance.setCategories(data);
              context.router.navigateNamed('home');
            }
          },
          builder: (context, state) {
            return body(context, state);
          },
        ),
      ),
    );
  }

  Form body(BuildContext context, RegisterState state) {
    return Form(
      key: _formKey,
      autovalidateMode: state is RegisterValidationState
          ? (state.registerValidation
              ? AutovalidateMode.always
              : AutovalidateMode.disabled)
          : AutovalidateMode.disabled,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: context.dynamicHeight(0.05)),
              Center(
                  child: Text('register', style: context.appTextTheme.headline2)
                      .tr()),
              SizedBox(height: context.dynamicHeight(0.05)),
              nameField(),
              SizedBox(height: context.dynamicHeight(0.02)),
              mailField(),
              SizedBox(height: context.dynamicHeight(0.02)),
              passwordField(),
              SizedBox(height: context.dynamicHeight(0.02)),
              repeatPasswordField(),
              SizedBox(height: context.dynamicHeight(0.05)),
              Visibility(
                visible: state is RegisterStatus
                    ? (state.status == AuthStatuses.unsucsess ? true : false)
                    : false,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('already_taken',
                            textAlign: TextAlign.left,
                            style: context.appTextTheme.bodyText2!
                                .copyWith(color: Colors.red))
                        .tr(),
                  ),
                ),
              ),
              CustomButton(
                voidCallback: () async =>
                    await context.read<RegisterCubit>().postUserModel(),
                text: 'register',
                loading: state is RegisterStatus
                    ? (state.status == AuthStatuses.started ? true : false)
                    : false,
              ),
              SizedBox(height: context.dynamicHeight(0.02)),
              const SentenceTextButton(text: 'do_have', routeName: '/login'),
              SizedBox(height: context.dynamicHeight(0.05)),
            ],
          ),
        ),
      ),
    );
  }

  CustomTextField nameField() => CustomTextField(
      prefixIconData: Icons.person,
      hintText: 'name',
      controller: _nameController,
      validator: (String? str) => getValidator(str, ValidationType.name));

  CustomTextField mailField() => CustomTextField(
      prefixIconData: Icons.mail,
      hintText: 'mail',
      controller: _mailController,
      validator: (String? str) => getValidator(str, ValidationType.email));

  CustomTextField passwordField() => CustomTextField(
      prefixIconData: Icons.lock,
      hintText: 'password',
      obscure: true,
      controller: _passwordController,
      validator: (String? str) => getValidator(str, ValidationType.password));

  CustomTextField repeatPasswordField() => CustomTextField(
      prefixIconData: Icons.repeat,
      hintText: 'password_repeat',
      obscure: true,
      controller: _repeatPassController,
      validator: (String? str) => getValidator(
          str, ValidationType.repeatPassword,
          firstStr: _passwordController.text));
}
