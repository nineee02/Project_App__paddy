import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class SelectWifiRoute extends StatefulWidget {
  const SelectWifiRoute({Key? key}) : super(key: key);

  @override
  _SelectWifiRouteState createState() => _SelectWifiRouteState();
}

class _SelectWifiRouteState extends State<SelectWifiRoute> {
  List<WiFiAccessPoint> accessPoints = [];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  TextEditingController passwordController = TextEditingController();
  String? selectedWifi;

  @override
  void initState() {
    super.initState();
    initWifiScan();
  }

  @override
  void dispose() {
    subscription?.cancel();
    passwordController.dispose();
    super.dispose();
  }

  void initWifiScan() async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      await WiFiScan.instance.startScan();
      subscription = WiFiScan.instance.onScannedResultsAvailable.listen(
        (List<WiFiAccessPoint> results) {
          setState(() {
            accessPoints = results;
          });
        },
      );
    } else {
      print('Location permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () => context.router.replaceNamed('/addDevice'),
          icon: Icon(Icons.arrow_back, color: iconcolor),
        ),
        title: Text("Select Wi-Fi network", style: TextStyle(color: fontcolor)),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'lib/assets/icon/home.png',
                  fit: BoxFit.contain,
                  width: 390,
                  height: 390,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "This device only supports 2.4GHz Wi-Fi",
                  style: TextStyle(fontSize: 16, color: fontcolor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Center(
                    child: Column(
                  children: [
                    Container(
                      width: 312,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: fill_color,
                        ),
                        value: selectedWifi,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedWifi = newValue;
                          });
                        },
                        items: accessPoints.map<DropdownMenuItem<String>>(
                            (WiFiAccessPoint value) {
                          return DropdownMenuItem<String>(
                            value: value.ssid,
                            child: Text(value.ssid),
                          );
                        }).toList(),
                        hint: Text("Select Wi-Fi network"),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 312,
                      height: 48,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Enter password",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: fill_color,
                          suffixIcon: Icon(Icons.visibility),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 312,
                      height: 48,
                      child: CustomButton(
                        text: "Next",
                        onPressed: () {
                          context.router.replaceNamed('/home');
                        },
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
