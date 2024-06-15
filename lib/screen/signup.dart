import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class SignupRoute extends StatefulWidget {
  const SignupRoute({Key? key}) : super(key: key);

  @override
  _SignupRouteState createState() => _SignupRouteState();
}

class _SignupRouteState extends State<SignupRoute> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isNameError = false;
  bool _isSurnameError = false;
  bool _isPhoneError = false;
  bool _isEmailError = false;
  bool _isPasswordError = false;
  bool _isConfirmPasswordError = false;

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _surnameFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _surnameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _signupUser(String name, String surname, String phone,
      String email, String password) async {
    final url = Uri.parse('http://10.0.2.2:3000/signup');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'surname': surname,
        'phone': phone,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Registration successful');
      _showSuccessDialog('Registration successful. Please log in.');
    } else if (response.statusCode == 400) {
      print('User already exists');
      _showErrorDialog('User already exists. Please log in.');
    } else {
      throw Exception('Failed to register user');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
              context.router.replaceNamed('/login');
            },
          )
        ],
      ),
    );
  }

  bool _validateFields() {
    setState(() {
      _isNameError = _nameController.text.length < 2;
      _isSurnameError = _surnameController.text.length < 2;
      _isPhoneError = !phoneRegex.hasMatch(_phoneController.text);
      _isEmailError = !emailRegex.hasMatch(_emailController.text);
      _isPasswordError =
          _passwordController.text != _confirmPasswordController.text ||
              _passwordController.text.isEmpty;
      _isConfirmPasswordError = _confirmPasswordController.text.isEmpty ||
          _passwordController.text != _confirmPasswordController.text;
    });

    return !(_isNameError ||
        _isSurnameError ||
        _isPhoneError ||
        _isEmailError ||
        _isPasswordError ||
        _isConfirmPasswordError);
  }

  final phoneRegex = RegExp(r'^[0-9]{10}$');
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () {
            context.router.replaceNamed('/login');
          },
          icon: Icon(Icons.arrow_back, color: iconcolor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0),
                Center(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                        color: fontcolor,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                  child: Text(
                    "Create a new account",
                    style: TextStyle(
                        color: fontcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _nameController,
                  "Name",
                  Icons.person_outline_outlined,
                  Icons.clear,
                  false,
                  _nameFocusNode,
                  _isNameError,
                  "Name must be at least 2 characters long",
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _surnameController,
                  "Surname",
                  Icons.person_outline,
                  Icons.clear,
                  false,
                  _surnameFocusNode,
                  _isSurnameError,
                  "Surname must be at least 2 characters long",
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _phoneController,
                  "Phone number",
                  Icons.phone_outlined,
                  Icons.clear,
                  false,
                  _phoneFocusNode,
                  _isPhoneError,
                  "Phone number must be 10 digits",
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _emailController,
                  "Email",
                  Icons.email_outlined,
                  Icons.clear,
                  false,
                  _emailFocusNode,
                  _isEmailError,
                  "Invalid email format",
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _passwordController,
                  "Password",
                  Icons.lock_outline,
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  true,
                  _passwordFocusNode,
                  _isPasswordError,
                  "Passwords do not match",
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _confirmPasswordController,
                  "Confirm Password",
                  Icons.lock_outline,
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  true,
                  _confirmPasswordFocusNode,
                  _isConfirmPasswordError,
                  "Passwords do not match",
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttoncolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      minimumSize: Size(312, 48),
                    ),
                    onPressed: () {
                      if (_validateFields()) {
                        _signupUser(
                          _nameController.text,
                          _surnameController.text,
                          _phoneController.text,
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          color: fontcolor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signupTextField(
    TextEditingController controller,
    String labelText,
    IconData prefixIcon,
    IconData suffixIcon,
    bool obscure,
    FocusNode focusNode,
    bool isError,
    String errorMessage,
  ) {
    return Container(
      width: 312,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            focusNode: focusNode,
            controller: controller,
            obscureText: (labelText == "Password" && _obscureText) ||
                (labelText == "Confirm Password" && _obscureText && obscure),
            decoration: InputDecoration(
              filled: true,
              fillColor: fill_color,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                  if (labelText == "Password" ||
                      labelText == "Confirm Password") {
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
                      : isError
                          ? error_color
                          : unnecessary_colors,
                  fontSize: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isError ? error_color : fill_color,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$labelText is required';
              }
              return null;
            },
          ),
          if (isError)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                errorMessage,
                style: TextStyle(color: error_color, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
