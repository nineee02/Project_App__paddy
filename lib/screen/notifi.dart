import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class NotifiRoute extends StatelessWidget {
  const NotifiRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: (IconButton(
            onPressed: () {
              context.router.replaceNamed('/home');
            },
            icon: Icon(Icons.arrow_back))),
        title: Text(
          "Notification",
          style: TextStyle(
              color: fontcolor, fontSize: 30, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.router.replaceNamed('/settingNotifi');
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      backgroundColor: maincolor,
      body: Center(
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
              ),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
