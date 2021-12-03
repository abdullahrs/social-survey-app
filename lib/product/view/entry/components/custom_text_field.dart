import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

typedef ValidatorFunction = String? Function(String?);
class CustomTextField extends StatelessWidget {
  final IconData prefixIconData;
  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  final ValidatorFunction validator;
  const CustomTextField({
    Key? key,
    required this.prefixIconData,
    required this.hintText,
    this.obscure = false,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIconData),
        hintText: hintText.tr(),
      ),
      obscureText: obscure,
      textAlignVertical: TextAlignVertical.center,
      validator: validator,
    );
  }
}
