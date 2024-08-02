import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/CustomTextField.dart';
import 'package:paddy_rice/widgets/shDialog.dart';

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
  void initState() {
    super.initState();

    _nameFocusNode.addListener(() {
      setState(() {});
    });

    _surnameFocusNode.addListener(() {
      setState(() {});
    });

    _phoneFocusNode.addListener(() {
      setState(() {});
    });

    _emailFocusNode.addListener(() {
      setState(() {});
    });

    _passwordFocusNode.addListener(() {
      setState(() {});
    });

    _confirmPasswordFocusNode.addListener(() {
      setState(() {});
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShDialog(
          title: 'Error',
          content: message,
          parentContext: context,
          confirmButtonText: 'Okay',
          cancelButtonText: '',
          onConfirm: () {
            Navigator.of(context).pop();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShDialog(
          title: 'Success',
          content: message,
          parentContext: context,
          confirmButtonText: 'Okay',
          cancelButtonText: '',
          onConfirm: () {
            Navigator.of(context).pop();
            context.router.replaceNamed('/login');
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
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
          onPressed: () => context.router.replaceNamed('/login'),
          icon: Icon(Icons.arrow_back, color: iconcolor),
        ),
        title: Text(
          "Create New Account",
          style: appBarFont,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16.0,
                ),
                Image.asset(
                  'lib/assets/icon/home.png',
                  height: 152.0,
                  width: 152.0,
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: _nameController,
                  labelText: "Name",
                  prefixIcon: Icons.person_outline_outlined,
                  suffixIcon: Icons.clear,
                  obscureText: false,
                  focusNode: _nameFocusNode,
                  isError: _isNameError,
                  errorMessage: "Name must be at least 2 characters long",
                  onSuffixIconPressed: () {
                    _nameController.clear();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    setState(() {
                      _isNameError = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: _surnameController,
                  labelText: "Surname",
                  prefixIcon: Icons.person_outline,
                  suffixIcon: Icons.clear,
                  obscureText: false,
                  focusNode: _surnameFocusNode,
                  isError: _isSurnameError,
                  errorMessage: "Surname must be at least 2 characters long",
                  onSuffixIconPressed: () {
                    _surnameController.clear();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your surname';
                    }
                    setState(() {
                      _isSurnameError = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: _phoneController,
                  labelText: "Phone number",
                  prefixIcon: Icons.phone_outlined,
                  suffixIcon: Icons.clear,
                  obscureText: false,
                  focusNode: _phoneFocusNode,
                  isError: _isPhoneError,
                  errorMessage: "Phone number must be 10 digits",
                  onSuffixIconPressed: () {
                    _phoneController.clear();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    setState(() {
                      _isPhoneError = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: _emailController,
                  labelText: "Email",
                  prefixIcon: Icons.email_outlined,
                  suffixIcon: Icons.clear,
                  obscureText: false,
                  focusNode: _emailFocusNode,
                  isError: _isEmailError,
                  errorMessage: "Invalid email format",
                  onSuffixIconPressed: () {
                    _emailController.clear();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    setState(() {
                      _isEmailError = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon:
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                  obscureText: _obscureText,
                  focusNode: _passwordFocusNode,
                  isError: _isPasswordError,
                  errorMessage: "Passwords do not match",
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
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: _confirmPasswordController,
                  labelText: "Confirm Password",
                  prefixIcon: Icons.lock_outline,
                  suffixIcon:
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                  obscureText: _obscureText,
                  focusNode: _confirmPasswordFocusNode,
                  isError: _isConfirmPasswordError,
                  errorMessage: "Passwords do not match",
                  onSuffixIconPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    setState(() {
                      _isConfirmPasswordError = false;
                    });
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: CustomButton(
                    text: "Sign up",
                    onPressed: () {
                      if (_validateFields()) {
                        _showSuccessDialog(
                            'Registration successful. Please log in.');
                        print('Signup button pressed');
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
