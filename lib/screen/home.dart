import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/screen/deviceState.dart';
import 'package:paddy_rice/widgets/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with WidgetsBindingObserver {
  List<Device> devices = [];
  bool isEditMode = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
    }
  }

  void addDevice(Device device) {
    setState(() {
      devices.add(device);
    });
  }

  void removeDevice(int index) {
    setState(() {
      devices.removeAt(index);
    });
  }

  void onDeviceTap(Device device) async {
    final updatedDevice = await Navigator.push<Device>(
      context,
      MaterialPageRoute(
        builder: (context) => DeviceSateRoute(device: device),
      ),
    );

    if (updatedDevice != null) {
      setState(() {
        int index = devices.indexWhere((d) => d.id == updatedDevice.id);
        if (index != -1) {
          devices[index] = updatedDevice;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(
          "Silo",
          style: appBarFont,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.router.replaceNamed('/notifi');
            },
            icon: Icon(
              Icons.notifications_outlined,
              size: 24,
              color: iconcolor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Icon(
                  Icons.add_circle_outline,
                  size: 24,
                  color: iconcolor,
                ),
                items: [
                  ...MenuItems.firstItems.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                  const DropdownMenuItem<Divider>(
                      enabled: false, child: Divider()),
                  ...MenuItems.secondItems.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                ],
                onChanged: (value) {
                  MenuItems.onChanged(context, value! as MenuItem);
                },
                dropdownStyleData: DropdownStyleData(
                  width: 160,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: fill_color,
                  ),
                  offset: const Offset(-144, 8),
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: [
                    ...List<double>.filled(MenuItems.firstItems.length, 48),
                    8,
                    ...List<double>.filled(MenuItems.secondItems.length, 48),
                  ],
                  padding: const EdgeInsets.only(left: 16, right: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
          ),
        ],
        selectedItemColor: iconcolor,
        unselectedItemColor: Color.fromRGBO(217, 217, 217, 1),
        onTap: (int index) {
          if (index == 0) {
            context.router.replaceNamed('/home');
          } else if (index == 1) {
            context.router.replaceNamed('/profile');
          }
        },
      ),
      backgroundColor: maincolor,
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 24),
              devices.isEmpty
                  ? Container(
                      width: 316,
                      height: 135,
                      decoration: BoxDecoration(
                        color: fill_color,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              'lib/assets/icon/home.png',
                              height: 94,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Divider(
                            height: 1.0,
                            color: Color.fromRGBO(215, 215, 215, 1),
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                          ),
                          Text(
                            "No devices",
                            style: TextStyle(
                                color: Color.fromRGBO(137, 137, 137, 1),
                                fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Container(
                        width: 316,
                        height: 135,
                        child: ListView.builder(
                          itemCount: devices.length,
                          itemBuilder: (context, index) {
                            final device = devices[index];
                            return GestureDetector(
                              onTap: () => onDeviceTap(device),
                              child: Container(
                                width: 316,
                                height: 135,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: fill_color,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                device.name,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "front",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.thermostat,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    "42° / ${device.frontTemp}°",
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "back",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.thermostat,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    "23° / ${device.backTemp}°",
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                    if (isEditMode)
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => removeDevice(index),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditMode = !isEditMode;
                  });
                },
                child: Text(
                  isEditMode ? "Done" : "Edit",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [
    devices,
    scan_qr,
  ];
  static const List<MenuItem> secondItems = [];

  static const devices =
      MenuItem(text: 'Add devices', icon: Icons.extension_outlined);
  static const scan_qr =
      MenuItem(text: 'Scan', icon: Icons.qr_code_scanner_outlined);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: iconcolor, size: 24),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Color.fromRGBO(77, 22, 0, 1),
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.devices:
        context.router.replaceNamed('/addDevice');
        break;
      case MenuItems.scan_qr:
        context.router.replaceNamed('/scan');
        break;
    }
  }
}
