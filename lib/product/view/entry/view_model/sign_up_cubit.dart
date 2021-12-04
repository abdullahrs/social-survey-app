import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController nameController;
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPassController;
  final GlobalKey<FormState> formKey;
  RegisterCubit(
      {required this.nameController,
      required this.mailController,
      required this.passwordController,
      required this.repeatPassController,
      required this.formKey})
      : super(RegisterInitial());
}

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterValidationState extends RegisterState {
  final bool registerValidation;

  RegisterValidationState(this.registerValidation);
}
