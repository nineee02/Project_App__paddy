import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginRute extends StatelessWidget {
  const LoginRute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 12, 221, 113),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login"),
              ElevatedButton(
                onPressed: () {
                  context.router.replaceNamed('/home');
                },
                child: Text("Go to Home"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
