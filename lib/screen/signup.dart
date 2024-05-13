import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
// import 'package:paddy_rice/router/routes.gr.dart';

@RoutePage()
class SignupRoute extends StatefulWidget {
  const SignupRoute({Key? key}) : super(key: key);

  @override
  _SignupRouteState createState() => _SignupRouteState();
}

class _SignupRouteState extends State<SignupRoute> {
  bool _obscureText = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: (IconButton(
            onPressed: () {
              context.router.replaceNamed('/login');
            },
            icon: Icon(Icons.arrow_back))),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Text(
                "Create Account",
                style: TextStyle(
                    color: fontcolor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Creare a new account",
                style: TextStyle(
                    color: fontcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16.0),
              signupTextField(_nameController, "Name",
                  Icons.person_outline_outlined, Icons.clear),
              const SizedBox(height: 16.0),
              signupTextField(_surnameController, "Surname",
                  Icons.person_outline, Icons.clear),
              const SizedBox(height: 16.0),
              signupTextField(
                  _emailController, "Email", Icons.email_outlined, Icons.clear),
              const SizedBox(height: 16.0),
              signupTextField(
                  _passwordController,
                  "Password",
                  Icons.lock_outline,
                  _obscureText ? Icons.visibility : Icons.visibility_off),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttoncolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minimumSize: Size(312, 48),
                ),
                onPressed: () => context.router.replaceNamed('/login'),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget signupTextField(TextEditingController controller, String labelText,
      IconData prefixIcon, IconData suffixIcon) {
    return Container(
      height: 48,
      width: 312,
      child: TextField(
        controller: controller,
        obscureText: labelText == "Password" && _obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: fill_color,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          prefixIcon: Icon(
            prefixIcon,
            color: iconcolor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              suffixIcon,
              color: iconcolor,
            ),
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
