import 'dart:async';
import 'dart:convert'; // For utf8 encoding
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/model.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class SelectWifiRoute extends StatefulWidget {
  final Device device;

  const SelectWifiRoute({required this.device, Key? key}) : super(key: key);

  @override
  _SelectWifiRouteState createState() => _SelectWifiRouteState();
}

class _SelectWifiRouteState extends State<SelectWifiRoute> {
  List<WiFiAccessPoint> accessPoints = [];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  TextEditingController passwordController = TextEditingController();
  String? selectedWifi;
  Color _labelColor = unnecessary_colors;
  Color _inputBorderColor = fill_color;
  bool _obscureText = true;
  FocusNode _passwordFocusNode = FocusNode();
  BluetoothCharacteristic? writeCharacteristic;

  @override
  void initState() {
    super.initState();
    initWifiScan();
    connectToDevice(widget.device.bluetoothDevice);
  }

  @override
  void dispose() {
    subscription?.cancel();
    passwordController.dispose();
    _passwordFocusNode.dispose();
    widget.device.bluetoothDevice?.disconnect();
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

  void connectToDevice(BluetoothDevice? device) async {
    if (device == null) {
      print('No Bluetooth device to connect');
      return;
    }

    try {
      await device.connect();
      final List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.properties.write) {
            setState(() {
              writeCharacteristic = characteristic;
            });
            break;
          }
        }
        if (writeCharacteristic != null) break;
      }
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }

  Future<void> sendWifiCredentials(String ssid, String password) async {
    if (writeCharacteristic != null) {
      await writeCharacteristic!.write(utf8.encode("SSID:$ssid\n"));
      await writeCharacteristic!.write(utf8.encode("PASS:$password\n"));
      print('Sent Wi-Fi credentials');
    } else {
      print('Write characteristic not found');
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
          title: Text(
            "Select Wi-Fi network",
            style: appBarFont,
          ),
          centerTitle: true),
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
                        height: 48,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            items: accessPoints.map<DropdownMenuItem<String>>(
                                (WiFiAccessPoint value) {
                              return DropdownMenuItem<String>(
                                value: value.ssid,
                                child: Text(
                                  value.ssid,
                                  style:
                                      TextStyle(fontSize: 16, color: fontcolor),
                                ),
                              );
                            }).toList(),
                            value: selectedWifi,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedWifi = newValue;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              width: 312,
                              decoration: BoxDecoration(
                                color: fill_color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            iconStyleData: IconStyleData(
                              icon: Icon(Icons.unfold_more_rounded),
                              iconSize: 24,
                              iconEnabledColor: iconcolor,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: fill_color,
                              ),
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              height: 40,
                            ),
                            hint: Text(
                              "Select Wi-Fi network",
                              style: TextStyle(
                                  fontSize: 16, color: unnecessary_colors),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 312,
                        height: 48,
                        child: TextFormField(
                          focusNode: _passwordFocusNode,
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: fill_color,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            labelText: "Enter password",
                            labelStyle: TextStyle(
                              color: _passwordFocusNode.hasFocus
                                  ? Colors.brown
                                  : _labelColor,
                              fontSize: 16,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: iconcolor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: _inputBorderColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.brown,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: error_color,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: error_color,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _passwordFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 312,
                        height: 48,
                        child: CustomButton(
                          text: "Next",
                          onPressed: () {
                            final ssid = selectedWifi;
                            final password = passwordController.text;
                            if (ssid != null && password.isNotEmpty) {
                              sendWifiCredentials(ssid, password);
                              // ส่งข้อมูล Wi-Fi กลับไปยัง HomeRoute
                              Navigator.pop(
                                  context, Device(ssid, 'unique-id', true));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please select a Wi-Fi network and enter the password.'),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
