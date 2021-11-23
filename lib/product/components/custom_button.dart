import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String text;
  const CustomButton({Key? key, required this.voidCallback, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: voidCallback,
      child: Text(text).tr(),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, context.dynamicHeight(0.065))),
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFF4b6b54)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
      ),
    );
  }
}
