// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i20;
import 'package:paddy_rice/screen/addDevice.dart' as _i1;
import 'package:paddy_rice/screen/changDeviceName.dart' as _i3;
import 'package:paddy_rice/screen/changepassword.dart' as _i4;
import 'package:paddy_rice/screen/ChangePassword_profile.dart' as _i5;
import 'package:paddy_rice/screen/deviceNotifiSetting.dart' as _i6;
import 'package:paddy_rice/screen/edit_profile.dart' as _i7;
import 'package:paddy_rice/screen/forgot.dart' as _i8;
import 'package:paddy_rice/screen/home.dart' as _i9;
import 'package:paddy_rice/screen/login.dart' as _i10;
import 'package:paddy_rice/screen/notifi.dart' as _i11;
import 'package:paddy_rice/screen/otp.dart' as _i12;
import 'package:paddy_rice/screen/profile.dart' as _i13;
import 'package:paddy_rice/screen/scan.dart' as _i14;
import 'package:paddy_rice/screen/selectWifi.dart' as _i15;
import 'package:paddy_rice/screen/settingNotifi.dart' as _i16;
import 'package:paddy_rice/screen/signup.dart' as _i17;
import 'package:paddy_rice/widgets/BottomNavigation.dart' as _i2;
import 'package:paddy_rice/widgets/model.dart' as _i19;

abstract class $AppRouter extends _i18.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    AddDeviceRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddDeviceRoute(),
      );
    },
    BottomNavigationRoute.name: (routeData) {
      final args = routeData.argsAs<BottomNavigationRouteArgs>(
          orElse: () => const BottomNavigationRouteArgs());
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BottomNavigationRoute(page: args.page),
      );
    },
    ChangeDeviceNameRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeDeviceNameRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ChangeDeviceNameRoute(device: args.device),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ChangePasswordRoute(),
      );
    },
    ChangePassword_profileRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ChangePassword_profileRoute(),
      );
    },
    DeviceNotifiSettingRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.DeviceNotifiSettingRoute(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EditProfileRoute(),
      );
    },
    ForgotRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ForgotRoute(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomeRoute(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginRoute(),
      );
    },
    NotifiRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.NotifiRoute(),
      );
    },
    OtpRoute.name: (routeData) {
      final args = routeData.argsAs<OtpRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.OtpRoute(
          key: args.key,
          inputValue: args.inputValue,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.ProfileRoute(),
      );
    },
    ScanRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.ScanRoute(),
      );
    },
    SelectWifiRoute.name: (routeData) {
      final args = routeData.argsAs<SelectWifiRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.SelectWifiRoute(
          device: args.device,
          key: args.key,
        ),
      );
    },
    SettingNotifiRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.SettingNotifiRoute(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.SignupRoute(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddDeviceRoute]
class AddDeviceRoute extends _i18.PageRouteInfo<void> {
  const AddDeviceRoute({List<_i18.PageRouteInfo>? children})
      : super(
          AddDeviceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddDeviceRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BottomNavigationRoute]
class BottomNavigationRoute
    extends _i18.PageRouteInfo<BottomNavigationRouteArgs> {
  BottomNavigationRoute({
    int page = 0,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          BottomNavigationRoute.name,
          args: BottomNavigationRouteArgs(page: page),
          initialChildren: children,
        );

  static const String name = 'BottomNavigationRoute';

  static const _i18.PageInfo<BottomNavigationRouteArgs> page =
      _i18.PageInfo<BottomNavigationRouteArgs>(name);
}

class BottomNavigationRouteArgs {
  const BottomNavigationRouteArgs({this.page = 0});

  final int page;

  @override
  String toString() {
    return 'BottomNavigationRouteArgs{page: $page}';
  }
}

/// generated route for
/// [_i3.ChangeDeviceNameRoute]
class ChangeDeviceNameRoute
    extends _i18.PageRouteInfo<ChangeDeviceNameRouteArgs> {
  ChangeDeviceNameRoute({
    required _i19.Device device,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ChangeDeviceNameRoute.name,
          args: ChangeDeviceNameRouteArgs(device: device),
          initialChildren: children,
        );

  static const String name = 'ChangeDeviceNameRoute';

  static const _i18.PageInfo<ChangeDeviceNameRouteArgs> page =
      _i18.PageInfo<ChangeDeviceNameRouteArgs>(name);
}

class ChangeDeviceNameRouteArgs {
  const ChangeDeviceNameRouteArgs({required this.device});

  final _i19.Device device;

  @override
  String toString() {
    return 'ChangeDeviceNameRouteArgs{device: $device}';
  }
}

/// generated route for
/// [_i4.ChangePasswordRoute]
class ChangePasswordRoute extends _i18.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangePassword_profileRoute]
class ChangePassword_profileRoute extends _i18.PageRouteInfo<void> {
  const ChangePassword_profileRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ChangePassword_profileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePassword_profileRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i6.DeviceNotifiSettingRoute]
class DeviceNotifiSettingRoute extends _i18.PageRouteInfo<void> {
  const DeviceNotifiSettingRoute({List<_i18.PageRouteInfo>? children})
      : super(
          DeviceNotifiSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeviceNotifiSettingRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i7.EditProfileRoute]
class EditProfileRoute extends _i18.PageRouteInfo<void> {
  const EditProfileRoute({List<_i18.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ForgotRoute]
class ForgotRoute extends _i18.PageRouteInfo<void> {
  const ForgotRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ForgotRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i9.HomeRoute]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginRoute]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i11.NotifiRoute]
class NotifiRoute extends _i18.PageRouteInfo<void> {
  const NotifiRoute({List<_i18.PageRouteInfo>? children})
      : super(
          NotifiRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotifiRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i12.OtpRoute]
class OtpRoute extends _i18.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    _i20.Key? key,
    required String inputValue,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          OtpRoute.name,
          args: OtpRouteArgs(
            key: key,
            inputValue: inputValue,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpRoute';

  static const _i18.PageInfo<OtpRouteArgs> page =
      _i18.PageInfo<OtpRouteArgs>(name);
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    required this.inputValue,
  });

  final _i20.Key? key;

  final String inputValue;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, inputValue: $inputValue}';
  }
}

/// generated route for
/// [_i13.ProfileRoute]
class ProfileRoute extends _i18.PageRouteInfo<void> {
  const ProfileRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i14.ScanRoute]
class ScanRoute extends _i18.PageRouteInfo<void> {
  const ScanRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ScanRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScanRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SelectWifiRoute]
class SelectWifiRoute extends _i18.PageRouteInfo<SelectWifiRouteArgs> {
  SelectWifiRoute({
    required _i19.Device device,
    _i20.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          SelectWifiRoute.name,
          args: SelectWifiRouteArgs(
            device: device,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectWifiRoute';

  static const _i18.PageInfo<SelectWifiRouteArgs> page =
      _i18.PageInfo<SelectWifiRouteArgs>(name);
}

class SelectWifiRouteArgs {
  const SelectWifiRouteArgs({
    required this.device,
    this.key,
  });

  final _i19.Device device;

  final _i20.Key? key;

  @override
  String toString() {
    return 'SelectWifiRouteArgs{device: $device, key: $key}';
  }
}

/// generated route for
/// [_i16.SettingNotifiRoute]
class SettingNotifiRoute extends _i18.PageRouteInfo<void> {
  const SettingNotifiRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SettingNotifiRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingNotifiRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i17.SignupRoute]
class SignupRoute extends _i18.PageRouteInfo<void> {
  const SignupRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}
