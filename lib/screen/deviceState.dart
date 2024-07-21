import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/widgets/model.dart';

class DeviceSateRoute extends StatefulWidget {
  final Device device;

  DeviceSateRoute({required this.device});

  @override
  _DeviceSateRouteState createState() => _DeviceSateRouteState();
}

class _DeviceSateRouteState extends State<DeviceSateRoute> {
  late String deviceName;
  late double frontTemp;
  late double backTemp;

  @override
  void initState() {
    super.initState();
    deviceName = widget.device.name;
    frontTemp = widget.device.frontTemp;
    backTemp = widget.device.backTemp;
  }

  void updateDeviceSettings() {
    setState(() {
      widget.device.name = deviceName;
      widget.device.frontTemp = frontTemp;
      widget.device.backTemp = backTemp;
    });
    Navigator.pop(context, widget.device); // ส่งข้อมูลกลับไปที่หน้า HomeRoute
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
          backgroundColor: maincolor,
          title: Text(
            widget.device.name,
            style: TextStyle(
                color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: iconcolor,
              ),
            ),
          ],
          centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings for ${widget.device.name}'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Device Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  deviceName = value;
                },
                controller: TextEditingController(text: deviceName),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Front Temperature',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  frontTemp = double.parse(value);
                },
                controller: TextEditingController(text: frontTemp.toString()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Back Temperature',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  backTemp = double.parse(value);
                },
                controller: TextEditingController(text: backTemp.toString()),
              ),
            ),
            ElevatedButton(
              onPressed: updateDeviceSettings,
              child: Text('Update Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
