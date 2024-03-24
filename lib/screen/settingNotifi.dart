import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class SettingNotifiRoute extends StatelessWidget {
  const SettingNotifiRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: (IconButton(
            onPressed: () {
              context.router.replaceNamed('/notifi');
            },
            icon: Icon(Icons.arrow_back))),
        title: Text(
          "Notification",
          style: TextStyle(
              color: fontcolor, fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 24.0, top: 40),
                child: Row(children: [
                  Text(
                    "Device messages",
                    style: TextStyle(
                        color: fontcolor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 24.0, top: 16),
                child: Row(children: [
                  Text(
                    "Device Notification",
                    style: TextStyle(
                        color: fontcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
