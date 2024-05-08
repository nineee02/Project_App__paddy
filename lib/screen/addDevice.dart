import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:flutter_blue/flutter_blue.dart';

@RoutePage()
class AddDeviceRoute extends StatefulWidget {
  const AddDeviceRoute({Key? key}) : super(key: key);

  @override
  _AddDeviceRouteState createState() => _AddDeviceRouteState();
}

class _AddDeviceRouteState extends State<AddDeviceRoute> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() {
    setState(() {
      isScanning = true;
    });
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        setState(() {
          devicesList.add(result.device);
        });
      }
    }).onDone(() => setState(() => isScanning = false));
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
        title: Text(
          "Add Device",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () => context.router.replaceNamed('/scan'),
            icon: Icon(Icons.qr_code_scanner),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  isScanning
                      ? LinearProgressIndicator()
                      : ElevatedButton(
                          onPressed: startScan,
                          child: Text('Scan for Devices'),
                        ),
                  SizedBox(height: 16),
                  Text('Discover nearby devices',
                      style: TextStyle(fontSize: 16, color: fontcolor)),
                  Text('Auto-detecting nearby devices...',
                      style:
                          TextStyle(fontSize: 14, color: unnecessary_colors)),
                  ...devicesList.map((device) => ListTile(
                        title: Text(device.name),
                        subtitle: Text(device.id.toString()),
                        onTap: () => connectToDevice(device),
                      )),
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Add devices manually',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: fontcolor)),
            ),
            Wrap(
              spacing: 10,
              children: [
                DeviceCategoryButton(icon: Icons.videocam, label: 'Devices'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      context.router.replaceNamed('/selectWifi');
    });
  }
}

class DeviceCategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const DeviceCategoryButton(
      {Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Implement functionality to add specific device type
      },
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: fontcolor,
        backgroundColor: fill_color,
        textStyle: TextStyle(color: iconcolor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
