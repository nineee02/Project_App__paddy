import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 233, 207, 1),
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
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
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
      backgroundColor: const Color.fromRGBO(255, 233, 207, 1),
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
