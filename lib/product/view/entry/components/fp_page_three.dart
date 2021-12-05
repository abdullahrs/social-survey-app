import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/components/custom_button.dart';
import 'package:anket/product/utils/text_field_validations.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class FPPageThree extends StatelessWidget {
  final GlobalKey<FormState> _passFormState;
  final TextEditingController _passController;
  final TextEditingController _repeatController;
  const FPPageThree(
      {Key? key,
      required GlobalKey<FormState> formState,
      required TextEditingController passController,
      required TextEditingController repeatController})
      : _passFormState = formState,
        _passController = passController,
        _repeatController = repeatController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _passFormState,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.dynamicHeight(0.1)),
            Text('forgot_pass'.tr(),
                style: context.appTextTheme.headline4!
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: context.dynamicHeight(0.1)),
            CustomTextField(
                prefixIconData: Icons.lock,
                hintText: 'password',
                controller: _passController,
                obscure: true,
                validator: (String? str) =>
                    getValidator(str, ValidationType.password)),
            SizedBox(height: context.dynamicHeight(0.05)),
            CustomTextField(
                prefixIconData: Icons.repeat,
                hintText: 'password_repeat',
                obscure: true,
                controller: _repeatController,
                validator: (String? str) => getValidator(
                    str, ValidationType.repeatPassword,
                    firstStr: _passController.text)),
            SizedBox(height: context.dynamicHeight(0.05)),
            CustomButton(
                voidCallback: () {
                  if (_passFormState.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
                text: "next"),
          ],
        ),
      ),
    );
  }
}
