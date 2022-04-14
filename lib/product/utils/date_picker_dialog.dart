import '../../core/extensions/buildcontext_extension.dart';
import '../constants/style/colors.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> kShowDatePickerDialog(BuildContext context,
    Function(DateTime) dateCallback, Function(bool) onSave) async {
  DateTime? dateTime;
  await showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
            height: context.dynamicHeight(0.475),
            color: AppStyle.scaffoldBackgroundColor,
            child: Column(
              children: [
                SizedBox(
                  height: context.dynamicHeight(0.4),
                  child: CupertinoDatePicker(
                      initialDateTime: DateTime.parse("1999-01-01"),
                      minimumDate: DateTime.parse("1930-01-01"),
                      maximumDate: DateTime.parse("2010-01-01"),
                      dateOrder: DatePickerDateOrder.dmy,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (val) {
                        dateTime=val;
                        dateCallback(val);
                      }),
                ),
                Expanded(
                  child: TextButton(
                    child: const Text('save').tr(),
                    onPressed: () {
                      onSave(true);
                      if(dateTime != null) dateCallback(dateTime!);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ));
}
