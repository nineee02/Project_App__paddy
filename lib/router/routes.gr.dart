// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:paddy_rice/screen/home.dart' as _i1;
import 'package:paddy_rice/screen/login.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeRute(),
      );
    },
    LoginRute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginRute(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeRute]
class HomeRute extends _i3.PageRouteInfo<void> {
  const HomeRute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginRute]
class LoginRute extends _i3.PageRouteInfo<void> {
  const LoginRute({List<_i3.PageRouteInfo>? children})
      : super(
          LoginRute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
