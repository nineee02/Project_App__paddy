import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 40,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 20.0),
              Text("Paddy Rice Drying Silo",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              Text("Control Notification",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              SizedBox(height: 24.0),
              Image.asset('lib/assets/icon/home.png', height: 214, width: 214),
              SizedBox(height: 24.0),
              loginTextField(_emailController, "Email or Phone number",
                  Icons.person_outline, Icons.clear),
              SizedBox(height: 16.0),
              loginTextField(
                  _passwordController,
                  "Password",
                  Icons.lock_outline,
                  _obscureText ? Icons.visibility : Icons.visibility_off),
              SizedBox(height: 4.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 48),
                  child: TextButton(
                    onPressed: () => context.router.replaceNamed('/forgot'),
                    child: Text("Forgot Password",
                        style:
                            TextStyle(color: unnecessary_colors, fontSize: 10)),
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttoncolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minimumSize: Size(312, 48),
                ),
                onPressed: () => context.router.replaceNamed('/home'),
                child: Text("Sign in",
                    style: TextStyle(
                        color: fontcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 4.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 48),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: TextStyle(
                          color: unnecessary_colors,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.router.replaceNamed('/signup'),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: fontcolor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginTextField(TextEditingController controller, String labelText,
      IconData prefixIcon, IconData suffixIcon) {
    return Container(
      width: 312,
      height: 48,
      child: TextField(
        controller: controller,
        obscureText: labelText == "Password" && _obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: fill_color,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          prefixIcon: Icon(prefixIcon, color: iconcolor),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon, color: iconcolor),
            onPressed: () {
              if (labelText == "Password") {
                setState(() {
                  _obscureText = !_obscureText;
                });
              } else {
                controller.clear();
              }
            },
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: unnecessary_colors, fontSize: 16),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: fill_color, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorder_color, width: 1)),
        ),
      ),
    );
  }
}
