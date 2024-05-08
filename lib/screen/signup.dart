import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class SignupRoute extends StatelessWidget {
  const SignupRoute({super.key});

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
        title: Text(
          "Create account",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  cursorColor: Color.fromRGBO(77, 22, 0, 1),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: iconcolor,
                    ),
                    labelText: "Name",
                    hintText: "Enter your name",
                    hintStyle: TextStyle(color: fontcolor, fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: fill_color,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: fill_color,
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
                  color: fill_color,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: iconcolor,
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Surname",
                    hintText: "Enter your Surname",
                    hintStyle: TextStyle(color: fontcolor, fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: fill_color,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: fill_color,
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
                  color: fill_color,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: iconcolor,
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Email",
                    hintText: "Enter your Email",
                    hintStyle: TextStyle(color: fontcolor, fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: fill_color,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: fill_color,
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
                  color: fill_color,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: iconcolor,
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Phone number",
                    hintText: "Enter your Phone number",
                    hintStyle: TextStyle(color: fontcolor, fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: fill_color,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: fill_color,
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
                  color: fill_color,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: iconcolor,
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Password",
                    hintText: "Enter your Password",
                    hintStyle: TextStyle(color: fontcolor, fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: fill_color,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: fill_color,
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
                  color: fill_color,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: iconcolor,
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Confirm Password",
                    hintText: "Enter your Confirm Password",
                    hintStyle: TextStyle(color: fontcolor, fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: fill_color,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: fill_color,
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
                  color: fill_color,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      buttoncolor,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.router.replaceNamed('/login');
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: fontcolor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 64,
              )
            ],
          ),
        ),
      ),
    );
  }
}
