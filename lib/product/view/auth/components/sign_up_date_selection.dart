import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../constants/style/colors.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DateCallback = Function(DateTime? date);

class DateSelector extends StatefulWidget {
  final DateCallback dateCallback;
  const DateSelector({Key? key, required this.dateCallback}) : super(key: key);

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? _chosenDateTime;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
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
                              setState(() {
                                _chosenDateTime = val;
                              });
                              widget.dateCallback(_chosenDateTime);
                            }),
                      ),
                      Expanded(
                        child: TextButton(
                          child: const Text('save').tr(),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ));
      },
      child: Container(
        height: context.dynamicHeight(0.06),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            // color: Colors.transparent,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[400]),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                _chosenDateTime == null
                    ? 'birth-date'.tr()
                    : _chosenDateTime.toString().substring(0, 10),
                style: context.appTextTheme.subtitle1!
                    .copyWith(color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
