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

  Color _emailBorderColor = fill_color;
  Color _labelColor = unnecessary_colors;

  FocusNode _emailFocusNode = FocusNode();

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
    if (_nameController.text.length < 2) {
      _showErrorDialog('Name must be at least 2 characters long');
      return false;
    }

    if (_surnameController.text.length < 2) {
      _showErrorDialog('Surname must be at least 2 characters long');
      return false;
    }

    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(_phoneController.text)) {
      _showErrorDialog('Phone number must be 10 digits');
      return false;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(_emailController.text)) {
      _showErrorDialog('Invalid email format');
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match');
      return false;
    }

    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showErrorDialog('Password fields cannot be empty');
      return false;
    }

    return true;
  }

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
          icon: Icon(Icons.arrow_back),
          color: iconcolor,
        )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                Text(
                  "Create Account",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Create a new account",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 16.0),
                signupTextField(_nameController, "Name",
                    Icons.person_outline_outlined, Icons.clear, false, null),
                const SizedBox(height: 16.0),
                signupTextField(_surnameController, "Surname",
                    Icons.person_outline, Icons.clear, false, null),
                const SizedBox(height: 16.0),
                signupTextField(_phoneController, "Phone number",
                    Icons.phone_outlined, Icons.clear, false, null),
                const SizedBox(height: 16.0),
                signupTextField(_emailController, "Email", Icons.email_outlined,
                    Icons.clear, false, _emailFocusNode),
                const SizedBox(height: 16.0),
                signupTextField(
                    _passwordController,
                    "Password",
                    Icons.lock_outline,
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    true,
                    null),
                const SizedBox(height: 16.0),
                signupTextField(
                    _confirmPasswordController,
                    "Confirm Password",
                    Icons.lock_outline,
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    true,
                    null),
                const SizedBox(height: 16.0),
                ElevatedButton(
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
    FocusNode? focusNode,
  ) {
    return Container(
      height: 48,
      width: 312,
      child: TextFormField(
        controller: controller,
        obscureText: (labelText == "Password" && _obscureText) ||
            (labelText == "Confirm Password" && _obscureText && obscure),
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: fill_color,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
              if (labelText == "Password" || labelText == "Confirm Password") {
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
              color: focusNode?.hasFocus == true
                  ? focusedBorder_color
                  : unnecessary_colors,
              fontSize: 16),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: fill_color, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorder_color, width: 1)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$labelText is required';
          }
          return null;
        },
      ),
    );
  }
}
