import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/screen/deviceState.dart';
import 'package:paddy_rice/widgets/decorated_image.dart';
import 'package:paddy_rice/widgets/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with WidgetsBindingObserver {
  List<Device> devices = [
    Device(name: "Device 1", id: "1", status: false),
    Device(name: "Device 2", id: "2", status: true),
  ];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
    }
  }

  void addDevice(Device device) {
    if (devices.any((d) => d.name == device.name)) {
      _showErrorSnackBar(S.of(context)!.device_already_exists);
      return;
    }
    setState(() => devices.add(device));
  }

  void removeDevice(int index) {
    setState(() => devices.removeAt(index));
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: error_color),
    );
  }

  Color _getDeviceStatusColor(bool status) {
    return status ? Color(0xFF80C080) : Color.fromRGBO(237, 76, 47, 1);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);
    MenuItems.init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(localizations!.title, style: appBarFont),
        actions: [
          IconButton(
            onPressed: () => context.router.replaceNamed('/notifi'),
            icon: Stack(
              children: <Widget>[
                Icon(Icons.notifications_outlined, size: 24, color: iconcolor),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(237, 76, 47, 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Icon(Icons.more_vert, size: 24, color: iconcolor),
                items: [
                  ...MenuItems.firstItems
                      .map((item) => DropdownMenuItem<MenuItem>(
                            value: item,
                            child: MenuItems.buildItem(item),
                          )),
                  const DropdownMenuItem<Divider>(
                      enabled: false, child: Divider()),
                  ...MenuItems.secondItems
                      .map((item) => DropdownMenuItem<MenuItem>(
                            value: item,
                            child: MenuItems.buildItem(item),
                          )),
                ],
                onChanged: (value) {
                  final menuItem = value as MenuItem;
                  if (menuItem.text == localizations.bluetooth) {
                    context.router.replaceNamed('/addDevice');
                  } else if (menuItem.text == localizations.qr_code) {
                    context.router.replaceNamed('/scan');
                  }
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
      backgroundColor: maincolor,
      body: Stack(
        children: [
          DecoratedImage(),
          Center(
            child: Column(
              children: [
                DecoratedImage(),
                SizedBox(height: 24),
                devices.isEmpty
                    ? _buildNoDevices(localizations)
                    : Expanded(child: _buildDeviceList(localizations)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDevices(S localizations) {
    return Container(
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
            localizations.no_devices,
            style: TextStyle(
              color: Color.fromRGBO(137, 137, 137, 1),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceList(S localizations) {
    return Container(
      width: 352,
      child: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              width: 352,
              height: 152,
              decoration: BoxDecoration(
                color: fill_color,
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(
                    color: _getDeviceStatusColor(device.status),
                    width: 8,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          device.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _getDeviceStatusColor(device.status),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ClipRRect(
                        child: Slidable(
                          key: ValueKey(device),
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => onDeviceTap(device),
                                backgroundColor:
                                    Color.fromRGBO(247, 145, 19, 1),
                                foregroundColor: fill_color,
                                icon: Icons.settings,
                                label: localizations.setting,
                              ),
                              SlidableAction(
                                onPressed: (context) => removeDevice(index),
                                backgroundColor: Color.fromRGBO(237, 76, 47, 1),
                                foregroundColor: fill_color,
                                icon: Icons.delete,
                                label: localizations.delete,
                              ),
                            ],
                          ),
                          child: Container(
                            width: 352,
                            height: 88,
                            decoration: BoxDecoration(
                              color: fill_color,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 9,
                                  // offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 8.0),
                                            Text(
                                              localizations.temp,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${localizations.front}: 24° / ${device.frontTemp}°",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              "${localizations.back}: 24° / ${device.backTemp}°",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              localizations.moisture,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            Text(
                                              "14 %",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
  static late MenuItem devices;
  static late MenuItem scan_qr;

  static late List<MenuItem> firstItems;
  static late List<MenuItem> secondItems;

  static void init(BuildContext context) {
    final localizations = S.of(context)!;
    devices = MenuItem(text: localizations.bluetooth, icon: Icons.bluetooth);
    scan_qr =
        MenuItem(text: localizations.qr_code, icon: Icons.qr_code_2_outlined);

    firstItems = [devices, scan_qr];
    secondItems = [];
  }

  static Widget buildItem(MenuItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(item.icon, color: iconcolor, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.text,
              style: const TextStyle(color: Color.fromRGBO(77, 22, 0, 1)),
            ),
          ),
        ],
      ),
    );
  }
}
