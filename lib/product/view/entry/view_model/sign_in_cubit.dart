import 'package:anket/core/src/cache_manager.dart';
import 'package:anket/product/constants/app_constants/hive_model_constants.dart';
import 'package:anket/product/constants/enums/auth_statuses.dart';
import 'package:anket/product/models/user.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final ModelCacheManager cacheManager;

  bool isLoginFailed = false;

  SignInCubit(
      {required this.mailController,
      required this.passwordController,
      required this.formKey,
      required this.cacheManager})
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState!.validate()) {
      emit(SignInStatus(AuthStatuses.started));
      UserModel? sucsess = await AuthService.login(
          email: mailController.text, password: passwordController.text);
      AuthStatuses authStatus = sucsess == null
          ? AuthStatuses.error
          : sucsess.tokens == null
              ? AuthStatuses.unsucsess
              : AuthStatuses.sucsess;
      // Race condition oluyor sanirim
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        emit(SignInStatus(authStatus));
      });

      if (sucsess?.tokens != null) {
        await cacheManager.putItem(
            HiveModelConstants.tokenKey, sucsess!.tokens!);
      }

      isLoginFailed = !(sucsess?.tokens != null);
    } else {
      isLoginFailed = true;
    }
    emit(SignInValidationState(isLoginFailed));
  }
}

abstract class SignInState {}

class LoginInitial extends SignInState {}

class SignInValidationState extends SignInState {
  final bool isValidate;
  SignInValidationState(this.isValidate);
}

class SignInStatus extends SignInState {
  final AuthStatuses status;
  SignInStatus(this.status);
}
