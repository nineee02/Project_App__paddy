// ignore_for_file: file_names

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class AddDeviceRoute extends StatelessWidget {
  const AddDeviceRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text("Add Device"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
