import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paddy_rice/constants/api.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';

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
        Uri.parse('${ApiConstants.baseUrl}/change_password'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie':
              'YOUR_SESSION_COOKIE_HERE', // Ensure session cookie is included
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

  void _validateAndProceed() {
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

    setState(() {
      _errorMessage = null;
    });

    // Replace with your desired action
    print('Password reset successful (simulated).');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset successful (simulated).')),
    );
    context.router.replaceNamed('/login');
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
          style: appBarFont,
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
              style: TextStyle(color: fontcolor, fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.0,
            ),
            Center(
              child: SizedBox(
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
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
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
            ),
            SizedBox(height: 16),
            Center(
              child: CustomButton(
                text: "Reset",
                onPressed: _validateAndProceed,
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
