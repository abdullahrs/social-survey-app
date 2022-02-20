import '../../../../core/widgets/loading_widget.dart';
import '../components/border_button.dart';
import '../view_model/initializer.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      InitializeValues initializeValues = InitializeValues();
      bool result = await initializeValues.setup(context);
      setState(() {
        isLoggedIn = result;
      });
    });
  }

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
            Visibility(
              visible: ((isLoggedIn != null) && (!isLoggedIn!)),
              child: Column(
                children: [
                  BorderButton(
                    text: 'login',
                    function: () {
                      context.router.pushNamed('/login');
                    },
                  ),
                  const SizedBox(height: 10),
                  BorderButton(
                    text: 'register',
                    function: () {
                      context.router.pushNamed('/register');
                    },
                  ),
                ],
              ),
            ),
            Visibility(visible: isLoggedIn == null, child: kLoadingWidget),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
