import 'dart:developer';
import 'dart:io';

import 'package:geolocator/geolocator.dart';

import 'product/constants/app_constants/hive_model_constants.dart';
import 'product/constants/app_constants/locals.dart';
import 'product/utils/lang_util.dart';
import 'product/utils/location_service/location_cubit.dart';
import 'product/utils/theme_util.dart';

import 'product/utils/survey_list_view_model/list_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'product/constants/style/theme.dart';
import 'product/router/routes.dart';
import 'product/utils/survey_cache_manager.dart';
import 'product/utils/survey_list_view_model/list_viewmodel_export.dart';
import 'product/utils/token_cache_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await TokenCacheManager().init();
  await SurveyCacheManager().init();
  runApp(EasyLocalization(
    supportedLocales: kSupportedLocales,
    path: 'assets/translations',
    fallbackLocale: kTrLocale,
    child: SurveyApp(),
  ));
}

class SurveyApp extends StatelessWidget {
  SurveyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    bool? mode =
        SurveyCacheManager.instance.getItem(HiveModelConstants.darkMode);
    String? langKey =
        SurveyCacheManager.instance.getItem(HiveModelConstants.lang);
    return MultiBlocProvider(
      providers: [
        BlocProvider<SurveyListViewModel>(
          create: (BuildContext context) => kSurveyListViewModel,
        ),
        BlocProvider(
            create: (_) =>
                ThemeCubit(mode ?? ThemeMode.system == ThemeMode.dark)),
        BlocProvider(
            create: (_) =>
                LocationCubit(geolocatorPlatform: GeolocatorPlatform.instance))
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: state.isDark ? darkTheme : lightTheme,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
