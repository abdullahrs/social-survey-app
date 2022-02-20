import '../../../utils/token_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/enums/auth_statuses.dart';
import '../../../models/user.dart';
import '../../../services/auth_service.dart';
import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';

class SignInCubit extends Cubit<SignInState> {
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final TokenCacheManager cacheManager = TokenCacheManager();
  final DataService _dataService = DataService.fromCache();
  final AuthService _authService = AuthService.fromCache();

  bool isLoginFailed = false;

  SignInCubit({
    required this.mailController,
    required this.passwordController,
    required this.formKey,
  }) : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState!.validate()) {
      emit(SignInStatus(AuthStatuses.started));
      User? sucsess = await _authService.login(
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
        var data = await _dataService.getCategories();
        await SurveyCacheManager.instance
            .setSubmittedSurveys(sucsess!.user!.submittedSurveys ?? []);
        await SurveyCacheManager.instance.setCategories(data);
        await SurveyCacheManager.instance.setUserID(sucsess.user!.id!);
      }

      isLoginFailed = !(sucsess?.tokens != null);
    } else {
      isLoginFailed = true;
    }
    emit(SignInValidationState(isLoginFailed));
  }
}

@immutable
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
