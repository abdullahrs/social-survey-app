import 'package:anket/product/constants/enums/login_statuses.dart';
import 'package:anket/product/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController nameController;
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPassController;
  final GlobalKey<FormState> formKey;

  bool isRegisterFailed = false;

  RegisterCubit(
      {required this.nameController,
      required this.mailController,
      required this.passwordController,
      required this.repeatPassController,
      required this.formKey})
      : super(RegisterInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterStatus(AuthStatuses.started));
      var sucsess = await AuthService.register(
        name: nameController.text,
        email: mailController.text,
        password: passwordController.text,
      );
      emit(RegisterStatus(sucsess == null
          ? AuthStatuses.error
          : sucsess.tokens == null
              ? AuthStatuses.unsucsess
              : AuthStatuses.sucsess));

      isRegisterFailed = false;
    } else {
      isRegisterFailed = true;
    }
    emit(RegisterValidationState(isRegisterFailed));
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
