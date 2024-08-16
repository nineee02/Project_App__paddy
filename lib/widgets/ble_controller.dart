import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:paddy_rice/router/routes.gr.dart';
import 'package:paddy_rice/widgets/model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart'; // สำหรับตรวจสอบ SDK version

class BleController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  Stream<List<ScanResult>>? _scanResults;
  bool isScanning = false;

  Stream<List<ScanResult>> get scanResults => _scanResults ?? Stream.empty();

  Future<void> _requestPermissions() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt >= 31) {
      // สำหรับ Android 12 ขึ้นไป
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();

      if (statuses[Permission.bluetoothScan] != PermissionStatus.granted ||
          statuses[Permission.bluetoothConnect] != PermissionStatus.granted ||
          statuses[Permission.location] != PermissionStatus.granted) {
        print("Permissions not granted");
        return;
      }
    } else {
      // สำหรับ Android 11 หรือต่ำกว่า
      PermissionStatus locationStatus = await Permission.location.request();
      if (locationStatus != PermissionStatus.granted) {
        print("Location permission not granted");
        return;
      }
    }
  }

  Future<void> scanDevices() async {
    await _requestPermissions();

    // เช็คว่า Bluetooth เปิดอยู่หรือไม่
    if (!await flutterBlue.isOn) {
      print("Bluetooth is not turned on");
      return;
    }

    // หยุดการสแกนก่อนหน้านี้เพื่อหลีกเลี่ยงข้อขัดแย้ง
    flutterBlue.stopScan();
    await Future.delayed(
        Duration(seconds: 1)); // หน่วงเวลาเล็กน้อยก่อนเริ่มการสแกนใหม่

    isScanning = true;
    update();

    // เริ่มสแกนอุปกรณ์
    try {
      flutterBlue.startScan(timeout: Duration(seconds: 15)).then((_) {
        isScanning = false;
        update();
      });

      _scanResults = flutterBlue.scanResults;
      update();
    } catch (e) {
      print("Error during scanning: $e");
      isScanning = false;
      update();
    }
  }

  Future<void> connectToDevice(BluetoothDevice device, String ssid) async {
    try {
      // ตรวจสอบว่าอุปกรณ์เชื่อมต่ออยู่หรือไม่
      List<BluetoothDevice> connectedDevices =
          await flutterBlue.connectedDevices;
      if (connectedDevices.contains(device)) {
        print("${device.name} is already connected");
        return;
      }

      // พยายามเชื่อมต่อกับอุปกรณ์
      await device.connect(
        timeout: Duration(seconds: 15),
        autoConnect: false,
      );

      BluetoothDeviceState currentState = await device.state.first;
      print("Initial state: $currentState");

      device.state.listen((state) {
        if (state == BluetoothDeviceState.connecting) {
          print("Connecting to ${device.name}");
        } else if (state == BluetoothDeviceState.connected) {
          print("Connected to ${device.name}");

          // นำทางไปยังหน้าเลือกรหัส Wi-Fi
          Get.to(() => SelectWifiRoute(
                  device: Device(
                bluetoothDevice: device,
                name: ssid,
                id: device.id.id,
                status: state == BluetoothDeviceState.connected,
              )));
        } else if (state == BluetoothDeviceState.disconnected) {
          print("Disconnected from ${device.name}");
        }
      });
    } catch (e) {
      print("Error connecting to device: $e");
    }
  }

  @override
  void onClose() {
    super.onClose();
    flutterBlue.stopScan();
  }
}
