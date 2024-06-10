import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class ChangePasswordRoute extends StatefulWidget {
  const ChangePasswordRoute({Key? key}) : super(key: key);

  @override
  _ChangePasswordRouteState createState() => _ChangePasswordRouteState();
}

class _ChangePasswordRouteState extends State<ChangePasswordRoute> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isNewPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  String? _errorMessage;

  void _changePassword() async {
    final String newPassword = _newPasswordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/change_password'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'YOUR_SESSION_COOKIE_HERE', // แทนที่ด้วยคุกกี้เซสชันจริง
        },
        body: jsonEncode({
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _errorMessage = null;
        });
        context.router.replaceNamed('/login');
      } else {
        setState(() {
          _errorMessage = response.body;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building ChangePasswordRoute Widget");
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconcolor),
          onPressed: () {
            context.router.replaceNamed('/otp');
          },
        ),
        title: Text(
          "Create New Password",
          style: TextStyle(
            color: fontcolor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your New Password Must Be Different \n from Previously Used Password',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 312,
              height: 48,
              child: TextFormField(
                controller: _newPasswordController,
                obscureText: _isNewPasswordObscured,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: fontcolor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconcolor),
                  ),
                  fillColor: fill_color,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: iconcolor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordObscured = !_isNewPasswordObscured;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 312,
              height: 48,
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isConfirmPasswordObscured,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: fontcolor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconcolor),
                  ),
                  fillColor: fill_color,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: iconcolor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordObscured =
                            !_isConfirmPasswordObscured;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 312,
              height: 48,
              child: ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttoncolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: fontcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: error_color),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
