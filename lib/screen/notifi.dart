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
          "Notification",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: fontcolor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.router.replaceNamed('/settingNotifi');
            },
            icon: Icon(
              Icons.settings,
              color: iconcolor,
            ),
          ),
        ],
      ),
      backgroundColor: maincolor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                "You have no new notifications",
                style: TextStyle(
                  color: fontcolor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
