import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paddy_rice/constants/color.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:paddy_rice/main.dart';

@RoutePage()
class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        actions: [
          IconButton(
            onPressed: () {
              context.router.replaceNamed('/notifi');
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: iconcolor,
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.add_circle_outline,
              color: iconcolor,
            ),
            onSelected: (value) {
              if (value == "Add device") {
                // context.router.replaceNamed('/addDevice');
                AutoRouter.of(context).replaceNamed('/addDevice');
              } else if (value == "Scan") {
                // context.router.replaceNamed('/scan');
                AutoRouter.of(context).replaceNamed('/scan');
              }
            },
            itemBuilder: (BuildContext context) {
              return {"Add device", "Scan"}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase(),
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        title: Text(
          "Silo",
          style: TextStyle(
              color: fontcolor, fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: iconcolor,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            label: "Profile",
          ),
        ],
        // selectedItemColor: Color.fromRGBO(255, 222, 47, 1),
        onTap: (int index) {
          if (index == 0) {
            context.router.replaceNamed('/home');
          } else if (index == 1) {
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
              Container(
                width: 316,
                height: 135,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/icon/home.png',
                      height: 94,
                      fit: BoxFit.contain,
                    ),
                    Divider(
                      height: 1.0,
                      color: Color.fromRGBO(215, 215, 215, 1),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                      "No devices",
                      style: TextStyle(
                          color: Color.fromRGBO(137, 137, 137, 1),
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: 316,
                height: 135,
                color: Color.fromRGBO(255, 255, 244, 1),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                  ),
                  onPressed: () {
                    context.router.replaceNamed('/device1');
                  },
                  child: Text(
                    "No devices",
                    style: TextStyle(
                        color: Color.fromRGBO(137, 137, 137, 1), fontSize: 16),
                  ),
                ),
              ),
              Container(),
              // Text(AppLocalizations.of(context)!.hello),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  context.router.replaceNamed('/scan');
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
