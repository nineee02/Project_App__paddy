import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'notification_service.dart'; // Import notification service

@RoutePage()
class NotifiRoute extends StatefulWidget {
  const NotifiRoute({super.key});

  @override
  _NotifiRouteState createState() => _NotifiRouteState();
}

class _NotifiRouteState extends State<NotifiRoute> {
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.initialize(); // Initialize notification service
  }

  void _sendNotification() {
    _notificationService.showNotification(
      id: 0,
      title: 'New Notification',
      body: 'This is a test notification',
    );
  }

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
          style: appBarFont,
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
              ElevatedButton(
                onPressed:
                    _sendNotification, // Send notification on button press
                child: Text('Send Test Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
