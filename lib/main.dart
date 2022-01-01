import 'product/constants/style/theme.dart';
import 'product/utils/survey_cache_manager.dart';
import 'product/utils/token_cache_manager.dart';
import 'product/view/entry/pages/welcome_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await TokenCacheManager().init();
  await SurveyCacheManager().init();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
    path: 'assets/translations',
    fallbackLocale: const Locale('tr', 'TR'),
    child: const SurveyApp(),
  ));
}

class SurveyApp extends StatelessWidget {
  const SurveyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: lightTheme,
      home: const WelcomePage(),
    );
  }
}
