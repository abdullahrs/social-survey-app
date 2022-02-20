import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../components/custom_button.dart';
import '../../../utils/text_field_validations.dart';
import 'custom_text_field.dart';

class PasswordResetTab extends StatefulWidget {
  final GlobalKey<FormState> _passFormState;
  final TextEditingController _passController;
  final TextEditingController _repeatController;
  final TextEditingController _codeController;
  final TextEditingController mailController;
  final Future<void> Function() onPressed;
  const PasswordResetTab(
      {Key? key,
      required GlobalKey<FormState> formState,
      required TextEditingController codeController,
      required TextEditingController passController,
      required TextEditingController repeatController,
      required this.mailController,
      required this.onPressed})
      : _codeController = codeController,
        _passFormState = formState,
        _passController = passController,
        _repeatController = repeatController,
        super(key: key);

  @override
  State<PasswordResetTab> createState() => _PasswordResetTabState();
}

class _PasswordResetTabState extends State<PasswordResetTab> {
  final FocusNode inputNode = FocusNode();

  String codeString = "";
  @override
  void initState() {
    super.initState();
    widget._codeController.addListener(() {
      if (widget._codeController.text != codeString) {
        setState(() {
          codeString = widget._codeController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._passFormState,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.dynamicHeight(0.1)),
            Text('forgot_pass'.tr(),
                style: context.appTextTheme.headline4!
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: context.dynamicHeight(0.05)),
            CustomTextField(
                prefixIconData: Icons.password,
                hintText: 'code',
                controller: widget._codeController,
                validator: (String? str) =>
                    getValidator(str, ValidationType.code)),
            SizedBox(height: context.dynamicHeight(0.025)),
            CustomTextField(
                prefixIconData: Icons.lock,
                hintText: 'password',
                controller: widget._passController,
                obscure: true,
                validator: (String? str) =>
                    getValidator(str, ValidationType.password)),
            SizedBox(height: context.dynamicHeight(0.025)),
            CustomTextField(
                prefixIconData: Icons.repeat,
                hintText: 'password_repeat',
                obscure: true,
                controller: widget._repeatController,
                validator: (String? str) => getValidator(
                    str, ValidationType.repeatPassword,
                    firstStr: widget._passController.text)),
            SizedBox(height: context.dynamicHeight(0.075)),
            CustomButton(
                voidCallback: () async => await widget.onPressed(),
                text: "next"),
          ],
        ),
      ),
    );
  }
}
