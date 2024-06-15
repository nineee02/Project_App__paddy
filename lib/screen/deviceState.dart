import 'package:flutter/material.dart';

class DeviceState with ChangeNotifier {
  bool _hasDevice = false;

  bool get hasDevice => _hasDevice;

  void addDevice() {
    _hasDevice = true;
    notifyListeners();
  }

  void removeDevice() {
    _hasDevice = false;
    notifyListeners();
  }
}
