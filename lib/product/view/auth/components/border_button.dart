import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';

class BorderButton extends StatelessWidget {
  final VoidCallback function;
  final String text;
  const BorderButton({
    Key? key,
    required this.function,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: ElevatedButton(
        onPressed: function,
        child: Text(text, style: context.appTextTheme.bodyText2).tr(),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
              Size(double.infinity, context.dynamicHeight(0.055))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
          )),
        ),
      ),
    );
  }
}
