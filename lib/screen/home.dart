import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
              icon: Icon(Icons.notifications_outlined)),
          PopupMenuButton<String>(
            icon: Icon(Icons.add_circle_outline),
            onSelected: (value) {
              if (value == "Add device") {
                context.router.replaceNamed('/addDevice');
              } else if (value == "Scan") {
                context.router.replaceNamed('/scan');
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
              color: Color.fromRGBO(77, 22, 0, 1),
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
                  context.router.replaceNamed('/login');
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: Color.fromRGBO(77, 22, 0, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     context.router.replaceNamed('/signup');
              //   },
              //   child: Text("Sign UP"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     MyApp.setLocale(context, Locale('th'));
              //   },
              //   child: Text("Change language thai"),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     MyApp.setLocale(context, Locale('en'));
              //   },
              //   child: Text("Change language english"),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
