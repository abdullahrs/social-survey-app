import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      emit(LoginStatus(false));
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://fd7a1991-8d21-499f-aa7b-231db6c4d466.mock.pstmn.io//auth/login'));
      // TODO: change
      // request.bodyFields = {'email': mailController.text, 'password': passwordController.text};
      request.bodyFields = {'email': 'johndoe@x.com', 'password': 'johndoe123'};
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
      emit(LoginStatus(true));
      isLoginFailed = false;
      emit(LoginValidationState(isLoginFailed));
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

class LoginStatus extends LoginState{
  final bool responseRecived;
  LoginStatus(this.responseRecived);
}