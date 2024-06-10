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

  Color _nameBorderColor = fill_color;
  Color _surnameBorderColor = fill_color;
  Color _phoneBorderColor = fill_color;
  Color _emailBorderColor = fill_color;
  Color _passwordBorderColor = fill_color;
  Color _confirmPasswordBorderColor = fill_color;

  Color _labelColor = unnecessary_colors;

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _surnameFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {
        _labelColor =
            _emailFocusNode.hasFocus ? focusedBorder_color : unnecessary_colors;
      });
    });
  }

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
      _nameBorderColor = fill_color;
      _surnameBorderColor = fill_color;
      _phoneBorderColor = fill_color;
      _emailBorderColor = fill_color;
      _passwordBorderColor = fill_color;
      _confirmPasswordBorderColor = fill_color;
    });

    bool isValid = true;

    if (_nameController.text.length < 2) {
      setState(() {
        _nameBorderColor = error_color;
      });
      isValid = false;
    }

    if (_surnameController.text.length < 2) {
      setState(() {
        _surnameBorderColor = error_color;
      });
      isValid = false;
    }

    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(_phoneController.text)) {
      setState(() {
        _phoneBorderColor = error_color;
      });
      isValid = false;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(_emailController.text)) {
      setState(() {
        _emailBorderColor = error_color;
      });
      isValid = false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _passwordBorderColor = error_color;
        _confirmPasswordBorderColor = error_color;
      });
      isValid = false;
    }

    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _passwordBorderColor = error_color;
        _confirmPasswordBorderColor = error_color;
      });
      isValid = false;
    }

    return isValid;
  }

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
                  _nameBorderColor,
                  _nameFocusNode,
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _surnameController,
                  "Surname",
                  Icons.person_outline,
                  Icons.clear,
                  false,
                  _surnameBorderColor,
                  _surnameFocusNode,
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _phoneController,
                  "Phone number",
                  Icons.phone_outlined,
                  Icons.clear,
                  false,
                  _phoneBorderColor,
                  _phoneFocusNode,
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _emailController,
                  "Email",
                  Icons.email_outlined,
                  Icons.clear,
                  false,
                  _emailBorderColor,
                  _emailFocusNode,
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _passwordController,
                  "Password",
                  Icons.lock_outline,
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  true,
                  _passwordBorderColor,
                  _passwordFocusNode,
                ),
                const SizedBox(height: 16.0),
                signupTextField(
                  _confirmPasswordController,
                  "Confirm Password",
                  Icons.lock_outline,
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  true,
                  _confirmPasswordBorderColor,
                  _confirmPasswordFocusNode,
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
    Color borderColor,
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
            borderSide: BorderSide(color: borderColor, width: 1),
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
    );
  }
}
