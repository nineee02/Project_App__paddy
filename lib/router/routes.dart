import 'package:auto_route/auto_route.dart';
// import 'package:flutter/foundation.dart';
import 'package:paddy_rice/router/routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            path: '/home',
            page: HomeRoute.page,
            initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/login',
            page: LoginRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/signup',
            page: SignupRoute.page,
            transitionsBuilder: TransitionsBuilders.zoomIn),
        CustomRoute(
            path: '/forgot',
            page: ForgotRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/profile',
            page: ProfileRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/notifi',
            page: NotifiRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn)
      ];
}
