import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isNewPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  void _validateAndProceed() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset successful (simulated).')),
      );
      context.router.replaceNamed('/login');
    }
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
                  child: Form(
                    key: _formKey,
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
                        _buildPasswordField(
                          controller: _newPasswordController,
                          labelText: 'New Password',
                          isObscured: _isNewPasswordObscured,
                          emptyErrorText: 'Please enter a new password',
                          onToggle: () {
                            setState(() {
                              _isNewPasswordObscured = !_isNewPasswordObscured;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        _buildPasswordField(
                          controller: _confirmPasswordController,
                          labelText: 'Confirm Password',
                          isObscured: _isConfirmPasswordObscured,
                          emptyErrorText: 'Please confirm your password',
                          onToggle: () {
                            setState(() {
                              _isConfirmPasswordObscured =
                                  !_isConfirmPasswordObscured;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        CustomButton(
                          text: "Reset",
                          onPressed: _validateAndProceed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required bool isObscured,
    required String emptyErrorText,
    required VoidCallback onToggle,
  }) {
    return Container(
      width: 312,
      child: TextFormField(
        controller: controller,
        obscureText: isObscured,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          labelStyle: TextStyle(color: fontcolor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: iconcolor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: error_color, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: error_color, width: 2),
          ),
          fillColor: fill_color,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              isObscured ? Icons.visibility : Icons.visibility_off,
              color: iconcolor,
            ),
            onPressed: onToggle,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return emptyErrorText;
          }
          if (labelText == 'Confirm Password' &&
              value != _newPasswordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }
}
