import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

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
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        child: Container(
          width: 390,
          height: 390,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/icon/home.png'),
              // fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
