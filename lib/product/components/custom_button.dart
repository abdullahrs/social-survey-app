import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/buildcontext_extension.dart';
import '../../core/widgets/loading_widget.dart';
import '../constants/style/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String text;
  final bool loading;
  const CustomButton(
      {Key? key,
      required this.voidCallback,
      required this.text,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: voidCallback,
      child: loading ? kLoadingWidget : Text(text).tr(),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
            Size(double.infinity, context.dynamicHeight(0.065))),
        backgroundColor:
            MaterialStateProperty.all<Color>(AppStyle.customButtonColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
      ),
    );
  }
}
