import 'package:anket/product/constants/enums/login_statuses.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  bool isLoginFailed = false;

  LoginCubit(this.mailController, this.passwordController, this.formKey)
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState!.validate()) {
      emit(LoginStatus(LoginStatuses.started));
      var sucsess = await AuthService.login(
          email: mailController.text, password: passwordController.text);
      emit(LoginStatus(sucsess == null
          ? LoginStatuses.error
          : sucsess.tokens == null
              ? LoginStatuses.unsucsess
              : LoginStatuses.sucsess));

      isLoginFailed = false;
      emit(LoginValidationState(false));
    } else {
      isLoginFailed = true;
      emit(LoginValidationState(isLoginFailed));
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginValidationState extends LoginState {
  final bool isValidate;
  LoginValidationState(this.isValidate);
}

class LoginStatus extends LoginState {
  final LoginStatuses status;
  LoginStatus(this.status);
}
