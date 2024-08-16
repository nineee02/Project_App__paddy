import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/router/routes.gr.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:paddy_rice/widgets/decorated_image.dart';

import '../widgets/CustomTextFieldNoiconfront.dart';

@RoutePage()
class ChangePassword_profileRoute extends StatefulWidget {
  @override
  _ChangePassword_profileRouteState createState() =>
      _ChangePassword_profileRouteState();
}

class _ChangePassword_profileRouteState
    extends State<ChangePassword_profileRoute> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isCurrentPasswordObscured = true;
  bool _isNewPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isPasswordError = false;
  String _errorMessage = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: iconcolor,
          ),
          onPressed: () =>
              context.router.replace(BottomNavigationRoute(page: 1)),
        ),
        title: Text(
          S.of(context)!.change_password,
          style: appBarFont,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          DecoratedImage(),
          Column(
            children: [
              Center(
                child: Column(
                  children: [
                    TextFieldCustom(
                      controller: _currentPasswordController,
                      labelText: "Current Password",
                      suffixIcon: _isCurrentPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off,
                      obscureText: _isCurrentPasswordObscured,
                      onSuffixIconPressed: () {
                        setState(() {
                          _isCurrentPasswordObscured =
                              !_isCurrentPasswordObscured;
                        });
                      },
                      isError: false,
                      errorMessage: '',
                    ),
                    const SizedBox(height: 20), // แก้ไขการพิมพ์ผิด
                    TextFieldCustom(
                      controller: _newPasswordController,
                      labelText: "New Password",
                      suffixIcon: _isNewPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off,
                      obscureText: _isNewPasswordObscured,
                      onSuffixIconPressed: () {
                        setState(() {
                          _isNewPasswordObscured = !_isNewPasswordObscured;
                        });
                      },
                      isError: false,
                      errorMessage: '',
                    ),
                    SizedBox(height: 20),
                    TextFieldCustom(
                      controller: _confirmPasswordController,
                      labelText: "Confirm New Password",
                      suffixIcon: _isConfirmPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off,
                      obscureText: _isConfirmPasswordObscured,
                      onSuffixIconPressed: () {
                        setState(() {
                          _isConfirmPasswordObscured =
                              !_isConfirmPasswordObscured;
                        });
                      },
                      isError: _isPasswordError,
                      errorMessage: _errorMessage,
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: "Reset Password",
                      onPressed: () async {
                        _validatePasswords(context);
                      },
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _validatePasswords(BuildContext context) async {
    setState(() {
      _isPasswordError = false;
      _errorMessage = '';
      isLoading = true;
    });

    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _isPasswordError = true;
        _errorMessage = "Please fill out all fields";
        isLoading = false;
      });
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _isPasswordError = true;
        _errorMessage = "New passwords do not match";
        isLoading = false;
      });
    } else {
      await Future.delayed(Duration(seconds: 3)); // จำลองการเชื่อมต่อ API

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset successful")),
      );

      Navigator.of(context).pop();
      context.router.replaceNamed('/bottom_navigation');
    }
  }
}
