import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/router/routes.gr.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/decorated_image.dart';
import 'package:paddy_rice/widgets/shDialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ForgotRoute extends StatefulWidget {
  const ForgotRoute({Key? key}) : super(key: key);

  @override
  _ForgotRouteState createState() => _ForgotRouteState();
}

class _ForgotRouteState extends State<ForgotRoute> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  Color _inputBorderColor = fill_color;
  FocusNode _inputFocusNode = FocusNode();
  Color _labelColor = unnecessary_colors;
  bool isLoading = false;

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
          title: S.of(context)!.user_not_found,
          content: S.of(context)!.user_not_found_prompt,
          parentContext: context,
          confirmButtonText: S.of(context)!.sign_up,
          cancelButtonText: S.of(context)!.cancel,
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

  bool _checkUserExists(String email) {
    List<String> existingUsers = ['user@example.com'];
    return existingUsers.contains(email);
  }

  Future<void> _validateAndContinue() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      final inputValue = _controller.text;

      await Future.delayed(Duration(seconds: 2)); // จำลองการตรวจสอบผู้ใช้

      if (_checkUserExists(inputValue)) {
        setState(() {
          isLoading = false;
        });
        context.router.push(OtpRoute(inputValue: inputValue));
      } else {
        setState(() {
          isLoading = false;
        });
        _showUserNotFoundDialog();
      }
    } else {
      setState(() {
        _inputBorderColor = error_color;
      });
      _showErrorSnackBar(S.of(context)!.correct_errors);
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
          S.of(context)!.forgot_password,
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
                color: fill_color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          DecoratedImage(),
          Column(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context)!.enter_email_verification,
                              style: TextStyle(
                                color: fontcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
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
                              labelText: S.of(context)!.email,
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context)!.enter_email_verification;
                              }
                              final emailRegex =
                                  RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                              if (!emailRegex.hasMatch(value)) {
                                return S.of(context)!.invalid_email_format;
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
                            text: S.of(context)!.send,
                            onPressed: _validateAndContinue,
                            isLoading: isLoading,
                          ),
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
}
