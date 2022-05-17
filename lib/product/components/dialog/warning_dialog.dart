import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/extensions/buildcontext_extension.dart';

Future<void> showWarningDialog(
  context, {
  required String text,
  required String imagePath,
  dynamic onDismiss,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        title: Column(
          children: [
            SvgPicture.asset(
              imagePath,
              width: context.dynamicWidth(0.5),
              height: context.dynamicWidth(0.5),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: context.dynamicWidth(0.075),
              child: Text(text,
                  style: context.appTextTheme.bodyText2!.copyWith(fontSize: 22)),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                if (onDismiss != null) {
                  await onDismiss();
                }
              },
              child: const Text('ok').tr(),
            ),
          )
        ],
      );
    },
  );
}
