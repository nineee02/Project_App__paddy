import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class SelectWifiRoute extends StatefulWidget {
  const SelectWifiRoute({Key? key}) : super(key: key);

  @override
  _SelectWifiRouteState createState() => _SelectWifiRouteState();
}

class _SelectWifiRouteState extends State<SelectWifiRoute> {
  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startListeningToScanResults();
  }

  @override
  void dispose() {
    super.dispose();
    _stopListeningToScanResults();
    passwordController.dispose();
  }

  Future<void> _startListeningToScanResults() async {
    subscription = WiFiScan.instance.onScannedResultsAvailable
        .listen((result) => setState(() => accessPoints = result));
  }

  void _stopListeningToScanResults() {
    subscription?.cancel();
    setState(() => accessPoints = <WiFiAccessPoint>[]);
  }

  Future<void> _startScan(BuildContext context) async {
    final result = await WiFiScan.instance.startScan();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("startScan: $result")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () {
            context.router.replaceNamed('/home');
          },
          icon: Icon(
            Icons.arrow_back,
            color: iconcolor,
          ),
        ),
        title: Text(
          "Select Wi-Fi network",
          style: TextStyle(
            color: fontcolor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 24),
              Container(
                // child: Column(
                //   children: [
                padding: EdgeInsets.only(right: 53),
                child: Text(
                  "This device only supports 2.4GHz Wi-Fi",
                  style: TextStyle(
                    color: fontcolor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // ],
                // ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.perm_scan_wifi),
                label: const Text('SCAN'),
                onPressed: () async => _startScan(context),
              ),
              const Divider(),
              // Flexible(
              //   child: Center(
              //     child: accessPoints.isEmpty
              //         ? const Text("NO SCANNED RESULTS")
              //         : ListView.builder(
              //             itemCount: accessPoints.length,
              //             itemBuilder: (context, i) => ListTile(
              //               title: Text(accessPoints[i].ssid),
              //               subtitle: Text(accessPoints[i].bssid),
              //             ),
              //           ),
              //   ),
              // ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: 312,
                  height: 48,
                  child: TextField(
                    controller: passwordController,
                    cursorColor: Color.fromRGBO(77, 22, 0, 1),
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                        color: fontcolor,
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1),
                        fontSize: 16,
                      ),
                      fillColor: Color.fromRGBO(255, 255, 244, 1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(255, 255, 244, 1),
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 244, 1),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: 312,
                  height: 48,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttoncolor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      context.router.replaceNamed('/home');
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: fontcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
