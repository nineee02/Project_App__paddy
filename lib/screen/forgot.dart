import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:paddy_rice/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:paddy_rice/constants/font_size.dart';
import 'dart:convert';

import 'package:paddy_rice/router/routes.gr.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/shDialog.dart';

final List<String> select_Value = [
  'Phone number',
  'Email',
];

@RoutePage()
class ForgotRoute extends StatefulWidget {
  const ForgotRoute({Key? key}) : super(key: key);

  @override
  _ForgotRouteState createState() => _ForgotRouteState();
}

class _ForgotRouteState extends State<ForgotRoute> {
  final _formKey = GlobalKey<FormState>();
  String? selectedValue = "Phone number";
  String hintText = "Please enter your phone number";
  final TextEditingController _controller = TextEditingController();

  Color _inputBorderColor = fill_color;
  FocusNode _inputFocusNode = FocusNode();
  Color _labelColor = unnecessary_colors;

  @override
  void initState() {
    super.initState();

    _inputFocusNode.addListener(() {
      setState(() {
        _labelColor =
            _inputFocusNode.hasFocus ? focusedBorder_color : unnecessary_colors;
      });
    });
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: error_color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showUserNotFoundDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShDialog(
          title: 'User not found',
          content:
              'User not found. Would you like to sign up or enter a different number?',
          parentContext: context,
          confirmButtonText: 'Sign Up',
          cancelButtonText: 'Not now',
          onConfirm: () {
            context.router.replaceNamed('/signup');
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<bool> checkUserExists(String type, String value) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/check_user_exists'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'type': type, 'value': value}),
      );

      if (response.statusCode == 200) {
        print('User exists');
        return true;
      } else {
        print('User not found');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<void> sendOtp(String type, String value) async {
    try {
      final userExists = await checkUserExists(type, value);

      if (!userExists) {
        _showUserNotFoundDialog();
        return;
      }

      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/send_otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'type': type, 'value': value}),
      );

      if (response.statusCode == 200) {
        // Log response body
        print('Response body: ${response.body}');

        // Decode response body safely
        try {
          final data = jsonDecode(response.body);
          print('OTP sent: ${data['otp']}');
          context.router.push(OtpRoute(
            inputType: type,
            inputValue: value,
          ));
        } catch (e) {
          print('Error decoding JSON: $e');
          _showErrorSnackBar('Failed to parse server response');
        }
      } else {
        print('Failed to send OTP');
        _showErrorSnackBar('Failed to send OTP');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorSnackBar('Failed to send OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () {
            context.router.replaceNamed('/login');
          },
          icon: Icon(Icons.arrow_back, color: iconcolor),
        ),
        title: Text(
          "Forgot Password",
          textAlign: TextAlign.center,
          style: appBarFont,
        ),
        centerTitle: true,
      ),
      backgroundColor: maincolor,
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
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please Enter Your Email or Phone To \n Receive a Verification Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: fontcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 312,
                      height: 48,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          items: select_Value
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 16, color: fontcolor),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                              if (value == 'Phone number') {
                                hintText = "Please enter your phone number";
                                _controller.clear();
                              } else {
                                hintText = "Please enter your Email";
                                _controller.clear();
                              }
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            width: 312,
                            decoration: BoxDecoration(
                              color: fill_color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          iconStyleData: IconStyleData(
                            icon: Icon(Icons.unfold_more_rounded),
                            iconSize: 24,
                            iconEnabledColor: iconcolor,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: fill_color,
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 312,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        focusNode: _inputFocusNode,
                        controller: _controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fill_color,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          labelText: selectedValue == 'Phone number'
                              ? 'Phone Number'
                              : 'Email',
                          hintText: hintText,
                          hintStyle: TextStyle(
                            color: unnecessary_colors,
                            fontSize: 16,
                          ),
                          labelStyle: TextStyle(
                            color: _labelColor,
                            fontSize: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: _inputBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: focusedBorder_color,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: error_color,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: error_color,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: selectedValue == 'Phone number'
                            ? TextInputType.phone
                            : TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          if (selectedValue == 'Phone number') {
                            final phoneRegex = RegExp(r'^[0-9]{10}$');
                            if (!phoneRegex.hasMatch(value)) {
                              return 'Phone number must be 10 digits';
                            }
                          } else {
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Invalid email format';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 312,
                      height: 48,
                      child: CustomButton(
                        text: "Continue",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final inputType = selectedValue == 'Phone number'
                                ? 'phone'
                                : 'email';
                            final inputValue = _controller.text;
                            print(
                                'Send OTP for $inputType: $inputValue (simulated).');
                            sendOtp(inputType, inputValue).catchError((error) {
                              _showErrorSnackBar('Failed to send OTP');
                            });
                          } else {
                            setState(() {
                              _inputBorderColor = error_color;
                            });
                            _showErrorSnackBar('Please correct the errors.');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
