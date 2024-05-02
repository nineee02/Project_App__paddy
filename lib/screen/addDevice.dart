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
        leading: (IconButton(
          onPressed: () {
            context.router.replaceNamed('/home');
          },
          icon: Icon(
            Icons.arrow_back,
            color: iconcolor,
          ),
        )),
        title: Text(
          "Add Device",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.router.replaceNamed('/scan');
              },
              icon: Icon(Icons.qr_code_scanner))
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "serial number",
                    hintText: "Enter your serial number",
                    hintStyle: TextStyle(color: fontcolor, fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(255, 255, 244, 1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(77, 22, 0, 1),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      buttoncolor,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.router.replaceNamed('/selectWifi');
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: fontcolor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
