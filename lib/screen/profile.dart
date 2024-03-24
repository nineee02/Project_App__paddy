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
              color: Color.fromRGBO(77, 22, 0, 1),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2,
              color: Color.fromRGBO(77, 22, 0, 1),
            ),
            label: "Profile",
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            context.router.replaceNamed('/home');
          }
          if (index == 1) {
            context.router.replaceNamed('/profile');
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
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
