import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class SelectWifiRoute extends StatelessWidget {
  const SelectWifiRoute({super.key});

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
          "Select Wi-Fi network",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Container(
                  child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                  ),
                  Text(
                    "This device only support 2.4GHz Wi-Fi",
                    style: TextStyle(
                        color: fontcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  cursorColor: Color.fromRGBO(77, 22, 0, 1),
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    hintStyle: TextStyle(
                      color: fontcolor,
                      fontSize: 16,
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(121, 121, 121, 1),
                      fontSize: 16,
                    ),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(255, 255, 244, 1),
                      ),
                    ),
                  ),
                ),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(255, 255, 244, 1)),
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
                    context.router.replaceNamed('/home');
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
            ],
          ),
        ),
      ),
    );
  }
}
