import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/router/routes.gr.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:paddy_rice/widgets/model.dart';

@RoutePage()
class AddDeviceRoute extends StatefulWidget {
  const AddDeviceRoute({Key? key}) : super(key: key);

  @override
  _AddDeviceRouteState createState() => _AddDeviceRouteState();
}

class _AddDeviceRouteState extends State<AddDeviceRoute> {
  List<BluetoothDevice> _devices = [];
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.location,
    ].request();

    if (await Permission.location.isGranted) {
      _scanDevices();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location permission is required to scan for devices'),
        ),
      );
    }
  }

  Future<void> _scanDevices() async {
    setState(() {
      isScanning = true;
      _devices.clear();
    });

    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!_devices.any((device) => device.id == result.device.id)) {
          setState(() {
            _devices.add(result.device);
          });
        }
      }
    }).onDone(() => setState(() => isScanning = false));
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connected to ${device.name}")),
      );
      context.router.push(
        SelectWifiRoute(
          device: Device(device.name, device.id.toString(), false),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect: ${e.toString()}")),
      );
    }
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () => context.router.replaceNamed('/home'),
          icon: Icon(Icons.arrow_back, color: iconcolor),
        ),
        title: Text("Add Device", style: appBarFont),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.router.replaceNamed('/scan'),
            icon: Icon(Icons.qr_code_scanner, color: iconcolor),
          )
        ],
      ),
      body: isScanning
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(iconcolor),
            ))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                BluetoothDevice device = _devices[index];
                return ListTile(
                  title: Text(device.name),
                  subtitle: Text(device.id.toString()),
                  trailing: ElevatedButton(
                    onPressed: () {
                      connectToDevice(device);
                    },
                    child: Text("Connect"),
                  ),
                );
              },
            ),
    );
  }
}
