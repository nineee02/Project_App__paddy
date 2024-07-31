import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';

@RoutePage()
class DeviceNotifiSettingRoute extends StatelessWidget {
  const DeviceNotifiSettingRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
          backgroundColor: maincolor,
          leading: IconButton(
            onPressed: () {
              context.router.replaceNamed('/settingNotifi');
            },
            icon: Icon(Icons.arrow_back, color: iconcolor),
          ),
          title: Text(
            "Device Notification Management",
            style: appBarFont,
          ),
          centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Text(
                  "Silo",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 16),
            buildSwitchTile("Device Notification"),
            const SizedBox(height: 16),
            buildSwitchTile("Temperature Alert"),
            const SizedBox(height: 16),
            buildSwitchTile("Humidity Alert"),
          ],
        ),
      ),
    );
  }

  Widget buildSwitchTile(String title) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        height: 48.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: fontcolor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SwitchMod(),
          ],
        ),
      ),
    );
  }
}

class SwitchMod extends StatefulWidget {
  const SwitchMod({super.key});

  @override
  State<SwitchMod> createState() => _SwitchModState();
}

class _SwitchModState extends State<SwitchMod> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xFF80C080);
        }
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xFF80C080).withOpacity(0.54);
        }
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }
        return null;
      },
    );

    return Switch(
      value: light,
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}
