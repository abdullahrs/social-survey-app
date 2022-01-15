import 'package:auto_route/auto_route.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // if (!isAuthenticated) {
    //   router.push(
    //     LoginRoute(onLoginResult: (_) {
    //       isAuthenticated = true;
    //       // we can't pop the bottom page in the navigator's stack
    //       // so we just remove it from our local stack
    //       resolver.next();
    //       router.removeLast();
    //     }),
    //   );
    // } else {
    //   resolver.next(true);
    // }
  }
}