// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'routes.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    WelcomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const WelcomePage());
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>(
          orElse: () => const SignInRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SignInPage(key: args.key));
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>(
          orElse: () => const SignUpRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SignUpPage(key: args.key));
    },
    ForgotPassRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPassRouteArgs>(
          orElse: () => const ForgotPassRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ForgotPassPage(
              key: args.key, navigateToReset: args.navigateToReset));
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    HomeMainRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    HomeCategoryRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    ParticipatedRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ParticipatedPage());
    },
    SettingsRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SettingsPage());
    },
    HomeMainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomeMainPage());
    },
    CategoryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const CategoryPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(WelcomeRoute.name, path: '/'),
        RouteConfig(SignInRoute.name, path: '/login'),
        RouteConfig(SignUpRoute.name, path: '/register'),
        RouteConfig(ForgotPassRoute.name, path: '/forgot'),
        RouteConfig(HomeRoute.name, path: 'home', children: [
          RouteConfig(HomeMainRouter.name,
              path: 'home-main',
              parent: HomeRoute.name,
              children: [
                RouteConfig(HomeMainRoute.name,
                    path: '', parent: HomeMainRouter.name)
              ]),
          RouteConfig(HomeCategoryRouter.name,
              path: 'home-category',
              parent: HomeRoute.name,
              children: [
                RouteConfig(CategoryRoute.name,
                    path: '', parent: HomeCategoryRouter.name)
              ]),
          RouteConfig(ParticipatedRouter.name,
              path: 'home-participated', parent: HomeRoute.name),
          RouteConfig(SettingsRouter.name,
              path: 'home-settings', parent: HomeRoute.name)
        ]),
        RouteConfig('*#redirect', path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute() : super(WelcomeRoute.name, path: '/');

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<SignInRouteArgs> {
  SignInRoute({Key? key})
      : super(SignInRoute.name,
            path: '/login', args: SignInRouteArgs(key: key));

  static const String name = 'SignInRoute';
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({Key? key})
      : super(SignUpRoute.name,
            path: '/register', args: SignUpRouteArgs(key: key));

  static const String name = 'SignUpRoute';
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ForgotPassPage]
class ForgotPassRoute extends PageRouteInfo<ForgotPassRouteArgs> {
  ForgotPassRoute({Key? key, bool navigateToReset = false})
      : super(ForgotPassRoute.name,
            path: '/forgot',
            args: ForgotPassRouteArgs(
                key: key, navigateToReset: navigateToReset));

  static const String name = 'ForgotPassRoute';
}

class ForgotPassRouteArgs {
  const ForgotPassRouteArgs({this.key, this.navigateToReset = false});

  final Key? key;

  final bool navigateToReset;

  @override
  String toString() {
    return 'ForgotPassRouteArgs{key: $key, navigateToReset: $navigateToReset}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [EmptyRouterPage]
class HomeMainRouter extends PageRouteInfo<void> {
  const HomeMainRouter({List<PageRouteInfo>? children})
      : super(HomeMainRouter.name,
            path: 'home-main', initialChildren: children);

  static const String name = 'HomeMainRouter';
}

/// generated route for
/// [EmptyRouterPage]
class HomeCategoryRouter extends PageRouteInfo<void> {
  const HomeCategoryRouter({List<PageRouteInfo>? children})
      : super(HomeCategoryRouter.name,
            path: 'home-category', initialChildren: children);

  static const String name = 'HomeCategoryRouter';
}

/// generated route for
/// [ParticipatedPage]
class ParticipatedRouter extends PageRouteInfo<void> {
  const ParticipatedRouter()
      : super(ParticipatedRouter.name, path: 'home-participated');

  static const String name = 'ParticipatedRouter';
}

/// generated route for
/// [SettingsPage]
class SettingsRouter extends PageRouteInfo<void> {
  const SettingsRouter() : super(SettingsRouter.name, path: 'home-settings');

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [HomeMainPage]
class HomeMainRoute extends PageRouteInfo<void> {
  const HomeMainRoute() : super(HomeMainRoute.name, path: '');

  static const String name = 'HomeMainRoute';
}

/// generated route for
/// [CategoryPage]
class CategoryRoute extends PageRouteInfo<void> {
  const CategoryRoute() : super(CategoryRoute.name, path: '');

  static const String name = 'CategoryRoute';
}
