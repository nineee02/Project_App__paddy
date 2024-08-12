import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/router/routes.gr.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/CustomTextFieldNoiconfront.dart';
import 'package:paddy_rice/widgets/decorated_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool passwordChanged = false;
  String? _newPasswordError;
  String? _confirmPasswordError;
  bool isLoading = false;

  Future<void> _validateAndProceed() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      passwordChanged = changePassword();

      await Future.delayed(Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });

      if (passwordChanged) {
        context.router.replaceAll([
          LoginRoute(),
        ]);
      }
    }
  }

  bool changePassword() {
    // จำลองการเปลี่ยนรหัสผ่านจริง, ควรเปลี่ยนเป็น logic จริง
    return true;
  }

  Future<void> _validatePasswords() async {
    setState(() {
      _newPasswordError = null;
      _confirmPasswordError = null;
      isLoading = true;
    });

    if (_newPasswordController.text.isEmpty) {
      setState(() {
        _newPasswordError = S.of(context)!.please_enter_new_password;
        isLoading = false;
      });
    } else if (_newPasswordController.text.length < 6) {
      setState(() {
        _newPasswordError = S.of(context)!.password_too_short;
        isLoading = false;
      });
    }

    if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _confirmPasswordError = S.of(context)!.please_confirm_your_password;
        isLoading = false;
      });
    } else if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = S.of(context)!.passwords_do_not_match;
        isLoading = false;
      });
    }

    if (_newPasswordError == null && _confirmPasswordError == null) {
      await _validateAndProceed();
    } else {
      setState(() {
        isLoading = false;
      });
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
        title: Text(S.of(context)!.reset_password, style: appBarFont),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            S.of(context)!.new_password_instruction,
                            style: TextStyle(
                              color: fontcolor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFieldCustom(
                          controller: _newPasswordController,
                          labelText: S.of(context)!.new_password,
                          suffixIcon: _isNewPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off,
                          obscureText: _isNewPasswordObscured,
                          isError: _newPasswordError != null,
                          errorMessage: _newPasswordError ?? '',
                          onSuffixIconPressed: () {
                            setState(() {
                              _isNewPasswordObscured = !_isNewPasswordObscured;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFieldCustom(
                          controller: _confirmPasswordController,
                          labelText: S.of(context)!.confirm_password,
                          suffixIcon: _isConfirmPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off,
                          obscureText: _isConfirmPasswordObscured,
                          isError: _confirmPasswordError != null,
                          errorMessage: _confirmPasswordError ?? '',
                          onSuffixIconPressed: () {
                            setState(() {
                              _isConfirmPasswordObscured =
                                  !_isConfirmPasswordObscured;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        CustomButton(
                          text: S.of(context)!.reset,
                          onPressed: _validatePasswords,
                          isLoading: isLoading,
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
