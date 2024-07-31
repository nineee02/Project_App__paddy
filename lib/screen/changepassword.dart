import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:paddy_rice/constants/api.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
  bool _isNewPasswordObscured = true, _isConfirmPasswordObscured = true;
  String? _errorMessage;

  void _changePassword() async {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() => _errorMessage = 'Please fill in all fields');
      return;
    }
    if (newPassword != confirmPassword) {
      setState(() => _errorMessage = 'Passwords do not match');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/change_password'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'YOUR_SESSION_COOKIE_HERE',
        },
        body: jsonEncode({
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        setState(() => _errorMessage = null);
        context.router.replaceNamed('/login');
      } else {
        setState(() => _errorMessage = response.body);
      }
    } catch (error) {
      setState(() => _errorMessage = 'An error occurred: $error');
    }
  }

  void _validateAndProceed() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() => _errorMessage = 'Please fill in all fields');
      return;
    }
    if (newPassword != confirmPassword) {
      setState(() => _errorMessage = 'Passwords do not match');
      return;
    }

    setState(() => _errorMessage = null);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset successful (simulated).')));
    context.router.replaceNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconcolor),
          onPressed: () => context.router.replaceNamed('/otp'),
        ),
        title: Text("Create New Password", style: appBarFont),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: -135,
            left: (MediaQuery.of(context).size.width - 456) / 2,
            child: Container(
              width: 456,
              height: 456,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage('lib/assets/icon/home.png'),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your new password must be different \nfrom any previously used passwords.',
                        style: TextStyle(
                            color: fontcolor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      _buildPasswordField(_newPasswordController,
                          'New Password', _isNewPasswordObscured, () {
                        setState(() =>
                            _isNewPasswordObscured = !_isNewPasswordObscured);
                      }),
                      SizedBox(height: 16),
                      _buildPasswordField(_confirmPasswordController,
                          'Confirm Password', _isConfirmPasswordObscured, () {
                        setState(() => _isConfirmPasswordObscured =
                            !_isConfirmPasswordObscured);
                      }),
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
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String labelText,
      bool isObscured, VoidCallback onToggle) {
    return Center(
      child: SizedBox(
        width: 312,
        height: 48,
        child: TextFormField(
          controller: controller,
          obscureText: isObscured,
          decoration: InputDecoration(
            labelText: labelText,
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
              icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off,
                  color: iconcolor),
              onPressed: onToggle,
            ),
          ),
        ),
      ),
    );
  }
}
