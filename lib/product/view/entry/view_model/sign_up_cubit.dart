import '../../../../core/src/cache_manager.dart';
import '../../../constants/app_constants/hive_model_constants.dart';
import '../../../constants/enums/auth_statuses.dart';
import '../../../models/user.dart';
import '../../../services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController nameController;
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPassController;
  final ModelCacheManager cacheManager;
  final GlobalKey<FormState> formKey;

  bool isRegisterFailed = false;

  RegisterCubit(
      {required this.nameController,
      required this.mailController,
      required this.passwordController,
      required this.repeatPassController,
      required this.formKey,
      required this.cacheManager})
      : super(RegisterInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterStatus(AuthStatuses.started));
      User? sucsess = await AuthService.instance.register(
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
      }

      isRegisterFailed = !(sucsess?.tokens != null);
    } else {
      isRegisterFailed = true;
    }
    emit(RegisterValidationState(!isRegisterFailed));
  }
}

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
