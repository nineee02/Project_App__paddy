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
  bool _isEmailError = false;
  bool _isPasswordError = false;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {});
    });

    _passwordFocusNode.addListener(() {
      setState(() {});
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
      _isEmailError = false;
      _isPasswordError = false;
    });

    if (response.statusCode == 200) {
      print('Login successful');
      context.router.replaceNamed('/home');
    } else {
      String errorMessage;
      if (response.statusCode == 401) {
        errorMessage = 'Invalid password. Please try again.';
        setState(() {
          _isPasswordError = true;
        });
      } else if (response.statusCode == 404) {
        errorMessage = 'User not found. Please sign up.';
        setState(() {
          _isEmailError = true;
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Paddy Rice Drying Silo \n Control Notification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 20,
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
                  _emailFocusNode,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or phone number';
                    }
                    setState(() {
                      _isEmailError = false;
                    });
                    return null;
                  },
                ),
                if (_isEmailError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'User not found. Please sign up.',
                        style: TextStyle(color: error_color, fontSize: 12),
                      ),
                    ),
                  ),
                SizedBox(height: 16.0),
                loginTextField(
                  _passwordController,
                  "Password",
                  Icons.lock_outline,
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  _passwordFocusNode,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    setState(() {
                      _isPasswordError = false;
                    });
                    return null;
                  },
                ),
                if (_isPasswordError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Invalid password. Please try again.',
                        style: TextStyle(color: error_color, fontSize: 12),
                      ),
                    ),
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
                            TextStyle(color: unnecessary_colors, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttoncolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
                SizedBox(height: 8.0),
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
                            fontSize: 12,
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
                                decoration: TextDecoration.underline,
                                fontSize: 12,
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
    FocusNode focusNode,
    String? Function(String?)? validator,
  ) {
    return Container(
      width: 312,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                    : (labelText == "Email or Phone number" && _isEmailError) ||
                            (labelText == "Password" && _isPasswordError)
                        ? error_color
                        : unnecessary_colors,
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      (labelText == "Email or Phone number" && _isEmailError) ||
                              (labelText == "Password" && _isPasswordError)
                          ? error_color
                          : fill_color,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorder_color, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error_color, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error_color, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
