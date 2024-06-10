import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class SettingNotifiRoute extends StatefulWidget {
  const SettingNotifiRoute({super.key});

  @override
  _SettingNotifiRouteState createState() => _SettingNotifiRouteState();
}

class _SettingNotifiRouteState extends State<SettingNotifiRoute> {
  bool showManagement = true;
  bool isNotificationEnabled = true;

  void toggleManagementVisibility(bool value) {
    setState(() {
      showManagement = value;
    });
  }

  void toggleNotification() {
    setState(() {
      isNotificationEnabled = !isNotificationEnabled;
      showManagement = isNotificationEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () {
            context.router.replaceNamed('/notifi');
          },
          icon: Icon(Icons.arrow_back, color: iconcolor),
        ),
        title: Text(
          "Notification setting",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Device messages",
              style: TextStyle(
                  color: fontcolor, fontSize: 12, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: toggleNotification,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                height: 48, // Ensuring a consistent height
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Device Notification",
                      style: TextStyle(
                          color: fontcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Switch(
                      value: isNotificationEnabled,
                      onChanged: (bool value) {
                        toggleNotification();
                      },
                      trackColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color.fromRGBO(27, 191, 0, 1);
                          }
                          return null;
                        },
                      ),
                      thumbColor:
                          const MaterialStatePropertyAll<Color>(Colors.black),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color.fromRGBO(27, 191, 0, 1)
                                .withOpacity(0.54);
                          }
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey.shade400;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (showManagement)
              ListTile(
                title: Text(
                  "Device Notification Management",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.chevron_right, color: iconcolor),
                onTap: () =>
                    context.router.replaceNamed('/deviceNotifiSetting'),
              ),
          ],
        ),
      ),
    );
  }
}
