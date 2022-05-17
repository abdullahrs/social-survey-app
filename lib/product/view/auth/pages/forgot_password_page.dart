import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';
import '../components/forgot_password_email_tab.dart';
import '../components/forgot_password_reset_pass_tab.dart';

class ForgotPassPage extends StatefulWidget {
  final bool navigateToReset;
  const ForgotPassPage({Key? key, this.navigateToReset = false})
      : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final PageController _pageController = PageController();

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();

  final GlobalKey<FormState> _passFormState = GlobalKey();
  final GlobalKey<FormState> _mailFormState = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.navigateToReset) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceIn);
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _mailController.dispose();
    _passController.dispose();
    _repeatController.dispose();
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
              MailTab(
                formState: _mailFormState,
                textEditingController: _mailController,
                onPressed: () async {
                  if (_mailFormState.currentState!.validate()) {
                    await AuthService.fromCache()
                        .forgotSendMail(_mailController.text);
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceOut);
                  }
                },
              ),
              PasswordResetTab(
                formState: _passFormState,
                codeController: _codeController,
                passController: _passController,
                repeatController: _repeatController,
                mailController: _mailController,
                onPressed: () async {
                  if (_passFormState.currentState!.validate()) {
                    await AuthService.fromCache().resetPassword(
                        email: _mailController.text,
                        password: _passController.text,
                        code: _codeController.text);
                    context.router.pop();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
