import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class ScanRoute extends StatelessWidget {
  const ScanRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: (IconButton(
            onPressed: () {
              context.router.replaceNamed('/home');
            },
            icon: Icon(
              Icons.arrow_back,
              color: iconcolor,
            ))),
        title: Text(
          "Scan",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            SizedBox(
              height: 16.0,
            ),
            Container(),
            SizedBox(
              height: 16.0,
            ),
            Container(),
            ElevatedButton(
                onPressed: () {
                  context.router.replaceNamed('/addDevice');
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(buttoncolor)),
                child: Text(
                  "No QR code available",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ))
          ],
        ),
      ),
    );
  }
}
