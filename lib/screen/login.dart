import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class LoginRoute extends StatelessWidget {
  const LoginRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Welcome",
                style: TextStyle(
                  color: const Color.fromRGBO(77, 22, 0, 1),
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 50.0),
                    ),
                    Text(
                      "Paddy Rice Drying Silo\n\n",
                      style: TextStyle(
                        color: const Color.fromRGBO(77, 22, 0, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Spacer(),
                    Text(
                      "Control Notification",
                      style: TextStyle(
                        color: const Color.fromRGBO(77, 22, 0, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 214,
              width: 214,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: AssetImage('lib/assets/icon/home.png'),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              width: 312,
              height: 48,
              child: TextField(
                cursorColor: Color.fromRGBO(77, 22, 0, 1),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Color.fromRGBO(77, 22, 0, 1),
                  ),

                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {},
                  ),
                  labelText: "Email or Phone number",
                  hintText: "Enter your Email or Phone number",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(77, 22, 0, 1),
                    fontSize: 16,
                  ),
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(121, 121, 121, 1),
                    fontSize: 16,
                  ),
                  fillColor: Color.fromRGBO(255, 255, 244, 1),
                  //helperText: 'supporting text',
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
            const SizedBox(height: 16.0),
            Container(
              width: 312,
              height: 48,
              child: TextField(
                cursorColor: Color.fromRGBO(77, 22, 0, 1),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color.fromRGBO(77, 22, 0, 1),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {},
                  ),
                  labelText: "Password",
                  hintText: "Enter your password",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(77, 22, 0, 1),
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
            Container(
              padding: EdgeInsets.only(left: 262.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.router.replaceNamed('/forgot');
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          color: Color.fromRGBO(121, 121, 121, 1),
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 312,
              height: 48,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(255, 222, 47, 1),
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
                  "Sign in",
                  style: TextStyle(
                    color: Color.fromRGBO(77, 22, 0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 310,
              height: 1,
              child: Column(
                children: [
                  Divider(
                    color: Color.fromRGBO(121, 121, 121, 1),
                    thickness: 1,
                  ),
                  // SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 145.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: TextStyle(
                      color: const Color.fromRGBO(137, 137, 137, 1),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.replaceNamed('/signup');
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: const Color.fromRGBO(77, 22, 0, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
