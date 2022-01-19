import '../../../utils/custom_exception.dart';

import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                function: () async {
                  try {
                    await login();
                    context.router.replaceNamed('home');
                  } catch (e) {
                    if (e is FetchDataException && e.statusCode == -1) {
                      await login();
                    } else {
                      context.router.pushNamed('/login');
                    }
                  }
                }),
            const SizedBox(height: 10),
            button(
                context: context,
                text: "register",
                function: () {
                  context.router.pushNamed('/register');
                }),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    var data = await DataService.instance.getCategories();
    await SurveyCacheManager.instance.setCategories(data);
    var submits = await DataService.instance
        .getSubmits(userID: SurveyCacheManager.instance.userID);
    if (submits != null) {
      await SurveyCacheManager.instance.setSubmittedSurveys(submits);
    }
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
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
          )),
        ),
      ),
    );
  }
}
