import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/utils/forgot_pass_util.dart';
import 'package:anket/product/utils/token_cache_manager.dart';
import 'package:anket/product/view/entry/pages/sign_in_page.dart';
import 'package:anket/product/view/entry/pages/sign_up_page.dart';
import 'package:anket/product/view/home/pages/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForgotPassUtil.instance.initUtil(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("app_name_nl",
                      style: context.appTextTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black))
                  .tr(),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("welcome_text",
                      style: context.appTextTheme.bodyText2!
                          .copyWith(fontSize: 20))
                  .tr(),
            ),
            const Spacer(),
            button(
                context: context,
                text: "login",
                function: () {
                  bool? control = TokenCacheManager().checkUserIsLogin();
                  if (control ?? false) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const Home()),
                        (_) => false);
                  } else {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => SignInPage()));
                  }
                }),
            const SizedBox(height: 10),
            button(
                context: context,
                text: "register",
                function: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SignUpPage()));
                }),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  SizedBox button(
      {required BuildContext context,
      required String text,
      required VoidCallback function}) {
    return SizedBox(
      width: context.screenWidth,
      child: ElevatedButton(
        onPressed: function,
        child: Text(text, style: context.appTextTheme.bodyText2).tr(),
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
                Size(double.infinity, context.dynamicHeight(0.055))),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
            ))),
      ),
    );
  }
}
