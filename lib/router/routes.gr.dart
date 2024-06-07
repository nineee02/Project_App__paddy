// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:paddy_rice/screen/addDevice.dart' as _i1;
import 'package:paddy_rice/screen/changepassword.dart' as _i2;
import 'package:paddy_rice/screen/device.dart' as _i4;
import 'package:paddy_rice/screen/deviceNotifiSetting.dart' as _i3;
import 'package:paddy_rice/screen/edit_profile.dart' as _i5;
import 'package:paddy_rice/screen/forgot.dart' as _i6;
import 'package:paddy_rice/screen/home.dart' as _i7;
import 'package:paddy_rice/screen/login.dart' as _i8;
import 'package:paddy_rice/screen/notifi.dart' as _i9;
import 'package:paddy_rice/screen/otp.dart' as _i10;
import 'package:paddy_rice/screen/profile.dart' as _i11;
import 'package:paddy_rice/screen/scan.dart' as _i12;
import 'package:paddy_rice/screen/selectWifi.dart' as _i13;
import 'package:paddy_rice/screen/settingNotifi.dart' as _i14;
import 'package:paddy_rice/screen/signup.dart' as _i15;

abstract class $AppRouter extends _i16.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    AddDeviceRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddDeviceRoute(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChangePasswordRoute(),
      );
    },
    DeviceNotifiSettingRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DeviceNotifiSettingRoute(),
      );
    },
    DeviceRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DeviceRoute(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EditProfileRoute(),
      );
    },
    ForgotRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ForgotRoute(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeRoute(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginRoute(),
      );
    },
    NotifiRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.NotifiRoute(),
      );
    },
    OtpRoute.name: (routeData) {
      final args = routeData.argsAs<OtpRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.OtpRoute(
          key: args.key,
          inputType: args.inputType,
          inputValue: args.inputValue,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ProfileRoute(),
      );
    },
    ScanRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ScanRoute(),
      );
    },
    SelectWifiRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SelectWifiRoute(),
      );
    },
    SettingNotifiRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.SettingNotifiRoute(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.SignupRoute(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddDeviceRoute]
class AddDeviceRoute extends _i16.PageRouteInfo<void> {
  const AddDeviceRoute({List<_i16.PageRouteInfo>? children})
      : super(
          AddDeviceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddDeviceRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChangePasswordRoute]
class ChangePasswordRoute extends _i16.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DeviceNotifiSettingRoute]
class DeviceNotifiSettingRoute extends _i16.PageRouteInfo<void> {
  const DeviceNotifiSettingRoute({List<_i16.PageRouteInfo>? children})
      : super(
          DeviceNotifiSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeviceNotifiSettingRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i4.DeviceRoute]
class DeviceRoute extends _i16.PageRouteInfo<void> {
  const DeviceRoute({List<_i16.PageRouteInfo>? children})
      : super(
          DeviceRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeviceRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EditProfileRoute]
class EditProfileRoute extends _i16.PageRouteInfo<void> {
  const EditProfileRoute({List<_i16.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ForgotRoute]
class ForgotRoute extends _i16.PageRouteInfo<void> {
  const ForgotRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ForgotRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeRoute]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoginRoute]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i9.NotifiRoute]
class NotifiRoute extends _i16.PageRouteInfo<void> {
  const NotifiRoute({List<_i16.PageRouteInfo>? children})
      : super(
          NotifiRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotifiRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i10.OtpRoute]
class OtpRoute extends _i16.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    _i17.Key? key,
    required String inputType,
    required String inputValue,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          OtpRoute.name,
          args: OtpRouteArgs(
            key: key,
            inputType: inputType,
            inputValue: inputValue,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpRoute';

  static const _i16.PageInfo<OtpRouteArgs> page =
      _i16.PageInfo<OtpRouteArgs>(name);
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    required this.inputType,
    required this.inputValue,
  });

  final _i17.Key? key;

  final String inputType;

  final String inputValue;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, inputType: $inputType, inputValue: $inputValue}';
  }
}

/// generated route for
/// [_i11.ProfileRoute]
class ProfileRoute extends _i16.PageRouteInfo<void> {
  const ProfileRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ScanRoute]
class ScanRoute extends _i16.PageRouteInfo<void> {
  const ScanRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ScanRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScanRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SelectWifiRoute]
class SelectWifiRoute extends _i16.PageRouteInfo<void> {
  const SelectWifiRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SelectWifiRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectWifiRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SettingNotifiRoute]
class SettingNotifiRoute extends _i16.PageRouteInfo<void> {
  const SettingNotifiRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SettingNotifiRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingNotifiRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SignupRoute]
class SignupRoute extends _i16.PageRouteInfo<void> {
  const SignupRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}
