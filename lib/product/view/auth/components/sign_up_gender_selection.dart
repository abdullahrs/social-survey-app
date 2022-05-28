import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../constants/enums/genders.dart';
import '../../../constants/style/colors.dart';

typedef GenderCallback = Function(Gender? gender);
class GenderSelection extends StatefulWidget {
  final GenderCallback callback;
  const GenderSelection({Key? key, required this.callback}) : super(key: key);

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  Gender? radioGroupValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppStyle.textFieldFillColor,
              border: Border.all(
                color: AppStyle.textFieldFillColor
              )
            ),
            child: RadioListTile<Gender>(
              title: const Text('female').tr(),
              value: Gender.female,
              groupValue: radioGroupValue,
              onChanged: (Gender? val) {
                setState(() {
                  if (val != null) {
                    radioGroupValue = val;
                  }
                  widget.callback(radioGroupValue);
                });
              },
            ),
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppStyle.textFieldFillColor,
              border: Border.all(
                color: AppStyle.textFieldFillColor
              )
            ),
            child: RadioListTile<Gender>(
              title: const Text('male').tr(),
              value: Gender.male,
              groupValue: radioGroupValue,
              onChanged: (Gender? val) {
                setState(() {
                  if (val != null) {
                    radioGroupValue = val;
                  }
                  widget.callback(radioGroupValue);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
