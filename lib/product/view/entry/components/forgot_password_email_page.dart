import '../../../services/auth_service.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../components/custom_button.dart';
import '../../../components/sign_up_text_button.dart';
import '../../../utils/text_field_validations.dart';
import 'custom_text_field.dart';

class FPPageOne extends StatelessWidget {
  final TextEditingController _mailController;
  final PageController _pageController;
  final GlobalKey<FormState> _mailFormState;
  const FPPageOne(
      {Key? key,
      required TextEditingController textEditingController,
      required PageController pageController,
      required GlobalKey<FormState> formState})
      : _mailController = textEditingController,
        _pageController = pageController,
        _mailFormState = formState,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _mailFormState,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.dynamicHeight(0.1)),
            Text(
              'forgot_pass'.tr(),
              style: context.appTextTheme.headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'forgot_pass_desc'.tr(),
              style: context.appTextTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.dynamicHeight(0.2)),
            CustomTextField(
                prefixIconData: Icons.mail_outline,
                hintText: 'mail',
                controller: _mailController,
                validator: (String? str) =>
                    getValidator(str, ValidationType.email)),
            SizedBox(height: context.dynamicHeight(0.05)),
            CustomButton(
              voidCallback: () async{
                if (_mailFormState.currentState!.validate()) {
                  await AuthService.instance.forgotSendMail(_mailController.text);
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.bounceOut);
                }
              },
              text: 'next',
            ),
            SizedBox(height: context.dynamicHeight(0.05)),
            const SentenceTextButton(
              text: 'dont_have',
              routeName: 'register',
            ),
          ],
        ),
      ),
    );
  }
}
