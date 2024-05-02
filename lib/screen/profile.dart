import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(
          "Profile",
          style: TextStyle(
              color: fontcolor, fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: Color.fromRGBO(217, 217, 217, 1),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2,
              // color: iconcolor,
            ),
            label: "Profile",
          ),
        ],
        selectedItemColor: Color.fromRGBO(217, 217, 217, 1),
        unselectedItemColor: iconcolor,
        onTap: (int index) {
          if (index == 0) {
            context.router.replaceNamed('/home');
          }
          if (index == 1) {
            context.router.replaceNamed('/profilehome');
          }
        },
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
              Container(
                padding: EdgeInsets.only(left: 24.0, top: 16),
                child: InkWell(
                  onTap: () {
                    context.router.replaceNamed('/account');
                  },
                  child: Row(
                    children: [
                      Text(
                        "My account",
                        style: TextStyle(
                            color: fontcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 88),
                      Icon(
                        Icons.chevron_right,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
              Container(),
              // Container(
              //   padding: EdgeInsets.only(left: 24.0, top: 16),
              //   child: InkWell(
              //     onTap: () {
              //       context.router.replaceNamed('/settingNotifi');
              //     },
              //     child: Row(
              //       children: [
              //         Text(
              //           "Notification setting",
              //           style: TextStyle(
              //               color: fontcolor,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w500),
              //         ),
              //         SizedBox(width: 88),
              //         Icon(
              //           Icons.chevron_right,
              //           size: 24.0,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                width: 312,
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(245, 247, 248, 1)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  onPressed: () {
                    context.router.replaceNamed('/login');
                  },
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                        color: Color.fromRGBO(254, 0, 0, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
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
