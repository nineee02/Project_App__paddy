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
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/login',
            page: LoginRoute.page,
            initial: true,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/signup',
            page: SignupRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
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
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/scan',
            page: ScanRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/addDevice',
            page: AddDeviceRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/selectWifi',
            page: SelectWifiRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/device',
            page: DeviceRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/settingNotifi',
            page: SettingNotifiRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/otp',
            page: OtpRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            path: '/deviceNotifiSetting',
            page: DeviceNotifiSettingRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn)
      ];
}
