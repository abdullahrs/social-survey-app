// import '../view/home/components/survey_list.dart' as survey_list;

import '../view/home/pages/home_categories.dart';
import '../view/home/pages/home_main.dart';
import '../view/home/pages/home_participated.dart';
import '../view/home/pages/home_settings.dart';

import '../view/entry/pages/forgot_password_page.dart';
import '../view/home/pages/home.dart';
import 'package:flutter/material.dart';

import '../view/entry/pages/sign_in_page.dart';
import '../view/entry/pages/sign_up_page.dart';
import '../view/entry/pages/welcome_page.dart';
import 'package:auto_route/auto_route.dart';

part 'routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page|Dialog,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: WelcomePage,
    ),
    AutoRoute(page: SignInPage, path: '/login'),
    AutoRoute(page: SignUpPage, path: '/register'),
    AutoRoute(page: ForgotPassPage, path: '/forgot'),
    // AutoRoute(page: SurveyPage, path: ':survey'),
    AutoRoute(
      page: HomePage,
      path: 'home',
      // guards: [AuthGuard],
      children: [
        AutoRoute(
          path: 'home-main',
          name: 'HomeMainRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: HomeMainPage),
            // AutoRoute(path: ':categoryId', page: survey_list.SurveyList),
          ],
        ),
        AutoRoute(
            path: 'home-category',
            name: 'HomeCategoryRouter',
            page: EmptyRouterPage,
            children: [
              AutoRoute(path: '', page: CategoryPage),
              // AutoRoute(path: ':categoryId', page: survey_list.SurveyList),
            ]),
        AutoRoute(
          page: ParticipatedPage,
          path: 'home-participated',
          name: 'ParticipatedRouter'
        ),
        AutoRoute(
          page: SettingsPage,
          path: 'home-settings',
          name: 'SettingsRouter'
        ),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class AppRouter extends _$AppRouter {}