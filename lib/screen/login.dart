import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Color _emailBorderColor = fill_color;
  Color _passwordBorderColor = fill_color;
  Color _labelColor = unnecessary_colors;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {
        _labelColor =
            _emailFocusNode.hasFocus ? focusedBorder_color : unnecessary_colors;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        _labelColor = _passwordFocusNode.hasFocus
            ? focusedBorder_color
            : unnecessary_colors;
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _sendUserData(String emailOrPhone, String password) async {
    final url = Uri.parse('http://10.0.2.2:3000/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'emailOrPhone': emailOrPhone,
        'password': password,
      }),
    );

    setState(() {
      _emailBorderColor = fill_color;
      _passwordBorderColor = fill_color;
    });

    if (response.statusCode == 200) {
      print('Login successful');
      context.router.replaceNamed('/home');
    } else {
      String errorMessage;
      if (response.statusCode == 401) {
        errorMessage = 'Invalid password. Please try again.';
        setState(() {
          _passwordBorderColor = error_color;
        });
      } else if (response.statusCode == 404) {
        errorMessage = 'User not found. Please sign up.';
        setState(() {
          _emailBorderColor = error_color;
        });
      } else {
        errorMessage = 'Failed to save user data';
      }
      _showErrorSnackBar(errorMessage);
    }
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: error_color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Paddy Rice Drying Silo \n Control Notification",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 24.0),
                Image.asset('lib/assets/icon/home.png',
                    height: 214, width: 214),
                SizedBox(height: 24.0),
                loginTextField(
                  _emailController,
                  "Email or Phone number",
                  Icons.person_outline,
                  Icons.clear,
                  _emailBorderColor,
                  _emailFocusNode,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                loginTextField(
                  _passwordController,
                  "Password",
                  Icons.lock_outline,
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  _passwordBorderColor,
                  _passwordFocusNode,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 48),
                    child: TextButton(
                      onPressed: () => context.router.replaceNamed('/forgot'),
                      child: Text(
                        "Forgot Password?",
                        style:
                            TextStyle(color: unnecessary_colors, fontSize: 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttoncolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: Size(312, 48),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendUserData(
                          _emailController.text, _passwordController.text);
                    }
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        color: fontcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
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
                          onPressed: () =>
                              context.router.replaceNamed('/signup'),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: fontcolor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
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
      ),
    );
  }

  Widget loginTextField(
    TextEditingController controller,
    String labelText,
    IconData prefixIcon,
    IconData suffixIcon,
    Color borderColor,
    FocusNode focusNode,
    String? Function(String?)? validator,
  ) {
    return Container(
      width: 312,
      child: Column(
        children: [
          TextFormField(
            focusNode: focusNode,
            controller: controller,
            obscureText: labelText == "Password" && _obscureText,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: fill_color,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
              labelStyle: TextStyle(
                color: focusNode.hasFocus
                    ? focusedBorder_color
                    : unnecessary_colors,
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorder_color, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error_color, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error_color, width: 1),
              ),
              errorStyle: TextStyle(color: error_color),
            ),
          ),
        ],
      ),
    );
  }
}
