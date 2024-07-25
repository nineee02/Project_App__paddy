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
          leading: (IconButton(
              onPressed: () {
                context.router.replaceNamed('/settingNotifi');
              },
              icon: Icon(Icons.arrow_back))),
          title: Text(
            "Device Notification Management",
            style: appBarFont,
          ),
          centerTitle: true),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 24.0, top: 40.0),
                child: Row(children: [
                  Text(
                    "Silo",
                    style: TextStyle(
                        color: fontcolor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 24.0, top: 16),
                child: Row(
                  children: [
                    Text(
                      "Device notification",
                      style: TextStyle(
                          color: fontcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    SwitchMod(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 24.0, top: 16),
                child: Row(
                  children: [
                    Text(
                      "Temperature alert",
                      style: TextStyle(
                          color: fontcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    SwitchMod(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 24.0, top: 16),
                child: Row(
                  children: [
                    Text(
                      "Humidity alert",
                      style: TextStyle(
                          color: fontcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    SwitchMod(),
                  ],
                ),
              ),
            ],
          ),
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
          // return Colors.amber;
        }
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Material color when switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Color(0xFF80C080).withOpacity(0.54);
          // return Colors.amber.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );

    return Switch(
      value: light,
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}
