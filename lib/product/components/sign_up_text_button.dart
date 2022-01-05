import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/buildcontext_extension.dart';
import '../constants/style/colors.dart';

class SentenceTextButton extends StatelessWidget {
  final String text;
  final String routeName;
  const SentenceTextButton(
      {Key? key, required this.text, required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: context.appTextTheme.bodyText2).tr(),
        InkWell(
            onTap: () => context.router.navigateNamed(routeName),
            child: Text(
              routeName.substring(1),
              style: const TextStyle(color: AppStyle.textButtonColor),
            ).tr()),
      ],
    );
  }
}
