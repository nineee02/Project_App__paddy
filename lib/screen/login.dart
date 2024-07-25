import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

import 'package:paddy_rice/constants/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/CustomTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final url = Uri.parse('${ApiConstants.baseUrl}/login');
    print('Attempting to connect to $url');
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
      final responseData = json.decode(response.body);
      final userId = responseData['userId'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setInt('userId', userId);

      print('Login successful, user ID: $userId');
      context.router.replaceNamed('/home');
    } else {
      if (response.statusCode == 401) {
        setState(() {
          _isPasswordError = true;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _isEmailError = true;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    }
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Paddy Rice Drying Silo \n Control Notification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: fontcolor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.0),
                Image.asset('lib/assets/icon/home.png',
                    height: 214, width: 214),
                SizedBox(height: 24.0),
                CustomTextField(
                  controller: _emailController,
                  labelText: "Email or Phone number",
                  prefixIcon: Icons.person_outline,
                  suffixIcon: Icons.clear,
                  obscureText: false,
                  focusNode: _emailFocusNode,
                  isError: _isEmailError,
                  errorMessage: 'User not found. Please sign up.',
                  onSuffixIconPressed: () {
                    _emailController.clear();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or phone number';
                    }
                    setState(() {
                      _isEmailError = false;
                    });
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon:
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                  obscureText: _obscureText,
                  focusNode: _passwordFocusNode,
                  isError: _isPasswordError,
                  errorMessage: 'Invalid password. Please try again.',
                  onSuffixIconPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    setState(() {
                      _isPasswordError = false;
                    });
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
                            TextStyle(color: unnecessary_colors, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                CustomButton(
                  text: "Sign in",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendUserData(
                          _emailController.text, _passwordController.text);
                      print('Login button pressed');
                    }
                  },
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
}
