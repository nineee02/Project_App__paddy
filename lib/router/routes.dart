import 'package:auto_route/auto_route.dart';
import 'package:paddy_rice/router/routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            path: '/home',
            page: HomeRute.page,
            initial: true,
            transitionsBuilder: TransitionsBuilders.slideBottom),
        CustomRoute(
            path: '/login',
            page: LoginRute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn)
      ];
}
