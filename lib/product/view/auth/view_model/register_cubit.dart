import '../../../utils/token_cache_manager.dart';

import '../../../constants/enums/genders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_constants/hive_model_constants.dart';
import '../../../constants/enums/auth_statuses.dart';
import '../../../models/user.dart';
import '../../../services/auth_service.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController nameController;
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPassController;
  final GlobalKey<FormState> formKey;
  final TokenCacheManager cacheManager = TokenCacheManager();
  final AuthService _authService = AuthService.fromCache();
  bool isRegisterFailed = false;

  Gender? gender;
  DateTime? birthDate;

  RegisterCubit({
    required this.nameController,
    required this.mailController,
    required this.passwordController,
    required this.repeatPassController,
    required this.formKey,
  }) : super(RegisterInitial());

  Future<void> postUserModel() async {
    if (birthDate == null || gender == null) {
      emit(RegisterStatus(AuthStatuses.error));
      return;
    }
    if (formKey.currentState!.validate()) {
      emit(RegisterStatus(AuthStatuses.started));
      User? sucsess = await _authService.register(
        name: nameController.text,
        email: mailController.text,
        password: passwordController.text,
      );

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        emit(RegisterStatus(sucsess == null
            ? AuthStatuses.error
            : sucsess.tokens == null
                ? AuthStatuses.unsucsess
                : AuthStatuses.sucsess));
      });

      if (sucsess?.tokens != null) {
        await cacheManager.putItem(
            HiveModelConstants.tokenKey, sucsess!.tokens!);
        await _authService.updateUser(
          userID: sucsess.user!.id!,
          gender: gender.toString().split(".")[1],
          date: birthDate.toString(),
        );
      }

      isRegisterFailed = !(sucsess?.tokens != null);
    } else {
      isRegisterFailed = true;
    }
    emit(RegisterValidationState(!isRegisterFailed));
  }

  void getGender(g) => gender = g;
  void getDate(d) => birthDate = d;
}

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterValidationState extends RegisterState {
  final bool registerValidation;

  RegisterValidationState(this.registerValidation);
}

class RegisterStatus extends RegisterState {
  final AuthStatuses status;
  RegisterStatus(this.status);
}
