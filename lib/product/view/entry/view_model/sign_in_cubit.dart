import 'package:anket/core/src/cache_manager.dart';
import 'package:anket/product/constants/app_constants/hive_model_constants.dart';
import 'package:anket/product/constants/enums/login_statuses.dart';
import 'package:anket/product/models/user.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final ICacheManager cacheManager;

  bool isLoginFailed = false;

  LoginCubit(
      {required this.mailController,
      required this.passwordController,
      required this.formKey,
      required this.cacheManager})
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState!.validate()) {
      emit(LoginStatus(AuthStatuses.started));
      UserModel? sucsess = await AuthService.login(
          email: mailController.text, password: passwordController.text);
      AuthStatuses status = sucsess == null
          ? AuthStatuses.error
          : sucsess.tokens == null
              ? AuthStatuses.unsucsess
              : AuthStatuses.sucsess;
      emit(LoginStatus(status));

      if (status == AuthStatuses.sucsess && sucsess?.tokens != null) {
        await cacheManager.putItem(
            HiveModelConstants.tokenKey, sucsess!.tokens!);
      }

      isLoginFailed = status == AuthStatuses.sucsess;
    } else {
      isLoginFailed = true;
    }
    emit(LoginValidationState(isLoginFailed));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginValidationState extends LoginState {
  final bool isValidate;
  LoginValidationState(this.isValidate);
}

class LoginStatus extends LoginState {
  final AuthStatuses status;
  LoginStatus(this.status);
}
