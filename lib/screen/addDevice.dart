import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/widgets/decorated_image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:paddy_rice/widgets/model.dart';
import 'package:paddy_rice/router/routes.gr.dart';

// class DeviceInfo {
//   String id;
//   String name;
//   double humidity;
//   DeviceInfo({required this.id, required this.name, required this.humidity});
// }

@RoutePage()
class AddDeviceRoute extends StatefulWidget {
  const AddDeviceRoute({Key? key}) : super(key: key);

  @override
  _AddDeviceRouteState createState() => _AddDeviceRouteState();
}

class _AddDeviceRouteState extends State<AddDeviceRoute> {
  // List<DeviceInfo> _devices = [
  //   DeviceInfo(id: "00:11:22:33:44:55", name: "Mock Device 1"),
  //   DeviceInfo(id: "66:77:88:99:AA:BB", name: "Mock Device 2"),
  // ];

  bool isScanning = false;
  bool scanComplete = false;

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
  }

  Future<void> _scanDevices() async {
    setState(() {
      isScanning = true;
      scanComplete = false;
    });

    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isScanning = false;
        scanComplete = true;
      });
    });
  }

  Widget _buildScanButton() {
    return ElevatedButton(
      onPressed: _scanDevices,
      child: Text(
        S.of(context)!.turn_on_now,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: fontcolor,
        backgroundColor: buttoncolor,
      ),
    );
  }

  // void _connectToDevice(DeviceInfo device) async {
  //   try {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(S.of(context)!.connected_to(device.name))),
  //     );
  //     context.router.push(
  //       SelectWifiRoute(
  //         device: Device(
  //             name: device.name,
  //             id: device.id,
  //             status: true,
  //             humidity: device.humidity),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(S.of(context)!.failed_to_connect(e.toString()))),
  //     );
  //   }
  // }

  // Widget _buildDeviceList() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemCount: _devices.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         title: Text(
  //           _devices[index].name,
  //           style: TextStyle(color: fontcolor),
  //         ),
  //         subtitle: Text(_devices[index].id),
  //         trailing: ElevatedButton(
  //           onPressed: () => _connectToDevice(_devices[index]),
  //           child: Text(S.of(context)!.connect),
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: buttoncolor,
  //             foregroundColor: fontcolor,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildAutomaticDetectionUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: buttoncolor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.bluetooth, color: iconcolor, size: 60),
        ),
        SizedBox(height: 20),
        Text(
          S.of(context)!.automatic_device_detection,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: fontcolor,
          ),
        ),
        Text(
          S.of(context)!.keep_mobile_near_device,
          style: TextStyle(color: unnecessary_colors),
        ),
        SizedBox(height: 30),
        // _buildDeviceList(),
      ],
    );
  }

  Widget _buildUI() {
    return isScanning
        ? Center(child: CircularProgressIndicator())
        : scanComplete
            ? _buildAutomaticDetectionUI()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bluetooth_searching, size: 50, color: iconcolor),
                  SizedBox(height: 20),
                  Text(
                    S.of(context)!.turn_on_bluetooth,
                    style: TextStyle(color: fontcolor),
                  ),
                  Text(
                    S.of(context)!.start_searching_for_devices,
                    style: TextStyle(color: unnecessary_colors),
                  ),
                  SizedBox(height: 20),
                  _buildScanButton(),
                ],
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () => context.router.replaceNamed('/bottom_navigation'),
          icon: Icon(Icons.arrow_back, color: iconcolor),
        ),
        title: Text(S.of(context)!.add_device, style: appBarFont),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          DecoratedImage(),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: _buildUI(),
            ),
          ),
        ],
      ),
    );
  }
}
