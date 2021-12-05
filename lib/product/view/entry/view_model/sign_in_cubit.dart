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
      emit(LoginStatus(AuthStatuses.started));
      var sucsess = await AuthService.login(
          email: mailController.text, password: passwordController.text);
      emit(LoginStatus(sucsess == null
          ? AuthStatuses.error
          : sucsess.tokens == null
              ? AuthStatuses.unsucsess
              : AuthStatuses.sucsess));

      isLoginFailed = false;
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
