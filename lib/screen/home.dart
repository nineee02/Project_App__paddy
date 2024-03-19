import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:paddy_rice/main.dart';

@RoutePage()
class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 233, 207, 1),
        actions: [
          IconButton(
              onPressed: () {
                context.router.replaceNamed('/notifi');
              },
              icon: Icon(Icons.notifications_outlined)),
          IconButton(
              onPressed: () {
                context.router.replaceNamed('/add');
              },
              icon: Icon(Icons.add_circle_outline))
        ],
        title: Text(
          "Silo",
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
        // selectedItemColor: Color.fromRGBO(255, 222, 47, 1),
        onTap: (int index) {
          if (index == 0) {
            context.router.replaceNamed('/home');
          } else if (index == 1) {
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
