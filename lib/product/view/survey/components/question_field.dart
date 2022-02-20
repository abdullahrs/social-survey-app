import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../constants/style/colors.dart';

class QuestionField extends StatelessWidget {
  const QuestionField({
    Key? key,
    required this.questionText,
  }) : super(key: key);

  final String questionText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        questionText,
        style: context.appTextTheme.headline5!
            .copyWith(color: AppStyle.textButtonColor),
      ),
    );
  }
}
