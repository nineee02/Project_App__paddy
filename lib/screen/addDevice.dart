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
      devicesList.clear();
    });
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devicesList.any((device) => device.id == result.device.id)) {
          setState(() {
            devicesList.add(result.device);
          });
        }
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
        title: Text("Add Device",
            style: TextStyle(
                color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.router.replaceNamed('/scan'),
            icon: Icon(Icons.qr_code_scanner, color: iconcolor),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover nearby devices',
                style: TextStyle(fontSize: 16, color: fontcolor),
              ),
              const SizedBox(height: 16),
              isScanning
                  ? LinearProgressIndicator()
                  : ElevatedButton(
                      onPressed: startScan,
                      child: Text('Scan for Devices'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: fontcolor,
                        backgroundColor: buttoncolor,
                      ),
                    ),
              const SizedBox(height: 16),
              Column(
                children: devicesList.map((device) {
                  return ListTile(
                    title: Text(device.name),
                    subtitle: Text(device.id.toString()),
                    onTap: () => connectToDevice(device),
                    trailing: Icon(Icons.bluetooth, color: iconcolor),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Divider(),
              ListTile(
                title: Text(
                  'Add devices manually',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: fontcolor),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                children: [
                  DeviceCategoryButton(icon: Icons.videocam, label: 'Camera'),
                  // Add more DeviceCategoryButton as needed
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      context.router.replaceNamed('/selectWifi');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to connect: ${e.toString()}")));
    }
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
        context.router.replaceNamed('/selectWifi');
      },
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: fontcolor,
        backgroundColor: buttoncolor,
        textStyle: TextStyle(color: iconcolor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
