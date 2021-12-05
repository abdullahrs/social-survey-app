import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/components/custom_button.dart';
import 'package:anket/product/components/sign_up_text_button.dart';
import 'package:anket/product/utils/text_field_validations.dart';
import 'package:anket/product/view/entry/components/custom_text_field.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final PageController _pageController = PageController();

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();

  final GlobalKey<FormState> _mailFormState = GlobalKey();
  final GlobalKey<FormState> _passFormState = GlobalKey();

  final FocusNode inputNode = FocusNode();

  String codeString = "";

  @override
  void initState() {
    super.initState();
    _codeController.addListener(() {
      if (_codeController.text != codeString) {
        setState(() {
          codeString = _codeController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Form(
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
                          controller: _textController,
                          validator: (String? str) =>
                              getValidator(str, ValidationType.email)),
                      SizedBox(height: context.dynamicHeight(0.05)),
                      CustomButton(
                        voidCallback: () {
                          if (_mailFormState.currentState!.validate()) {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.bounceOut);
                          }
                        },
                        text: 'next',
                      ),
                      SizedBox(height: context.dynamicHeight(0.05)),
                      const SignUpTextButton(),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: context.dynamicHeight(0.1)),
                    Text('forgot_pass'.tr(),
                        style: context.appTextTheme.headline4!
                            .copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: context.dynamicHeight(0.1)),
                    SizedBox(
                      height: context.dynamicWidth(0.2),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(
                            height: context.dynamicWidth(0.2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List<Widget>.generate(
                                  4,
                                  (index) => SizedBox(
                                        width: context.dynamicWidth(0.2),
                                        height: context.dynamicWidth(0.2),
                                        child: Card(
                                          color: const Color(0xFFecf2f0),
                                          child: Center(
                                              child: Text(getCode(index))),
                                        ),
                                      )),
                            ),
                          ),
                          SizedBox(
                            height: context.dynamicWidth(0.2),
                            child: TextField(
                              controller: _codeController,
                              focusNode: inputNode,
                              autofocus: true,
                              showCursor: false,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              maxLengthEnforcement: MaxLengthEnforcement.none,
                              enableInteractiveSelection: false,
                              style: const TextStyle(color: Colors.transparent),
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  counterText: ""),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.dynamicHeight(0.05)),
                    CustomButton(
                        voidCallback: () {
                          if (_codeController.text.length == 4) {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.bounceOut);
                          }
                        },
                        text: "next"),
                  ],
                ),
              ),
              Form(
                key: _passFormState,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: context.dynamicHeight(0.1)),
                      Text('forgot_pass'.tr(),
                          style: context.appTextTheme.headline4!
                              .copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(height: context.dynamicHeight(0.1)),
                      CustomTextField(
                          prefixIconData: Icons.lock,
                          hintText: 'password',
                          controller: _passController,
                          obscure: true,
                          validator: (String? str) =>
                              getValidator(str, ValidationType.password)),
                      SizedBox(height: context.dynamicHeight(0.05)),
                      CustomTextField(
                          prefixIconData: Icons.repeat,
                          hintText: 'password_repeat',
                          obscure: true,
                          controller: _repeatController,
                          validator: (String? str) => getValidator(
                              str, ValidationType.repeatPassword,
                              firstStr: _passController.text)),
                      SizedBox(height: context.dynamicHeight(0.05)),
                      CustomButton(
                          voidCallback: () {
                            if (_passFormState.currentState!.validate()) {
                              Navigator.of(context).pop();
                            }
                          },
                          text: "next"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  String getCode(int index) {
    String code;
    try {
      code = codeString[index];
    } catch (e) {
      return "";
    }
    return code;
  }
}
