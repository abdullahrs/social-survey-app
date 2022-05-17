import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    Key? key,
    required this.text,
    required this.borderColor,
    required this.textColor,
    required this.callback,
    this.backgroundColor,
  }) : super(key: key);

  final String text;
  final Color borderColor;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: context.dynamicWidth(0.75),
        height: context.dynamicWidth(0.75) / 6,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          text,
          style: context.appTextTheme.bodyText2!.copyWith(color: textColor),
        ),
      ),
    );
  }
}
