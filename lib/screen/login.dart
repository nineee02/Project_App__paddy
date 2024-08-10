import 'package:auto_route/auto_route.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/main.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/CustomTextField.dart';

@RoutePage()
class LoginRoute extends StatefulWidget {
  const LoginRoute({Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController _emailOrPhoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isEmailOrPhoneError = false;
  bool _isPasswordError = false;

  String? _errorMessage;
  Locale _locale = Locale('en');
  bool isEnglish = true;

  void _changeLanguage() {
    setState(() {
      isEnglish = !isEnglish;
      _locale = isEnglish ? Locale('en') : Locale('th');
      MyApp.setLocale(context, _locale);
    });
  }

  void login() {
    String emailOrPhone = _emailOrPhoneController.text;
    String password = _passwordController.text;

    final validEmailsOrPhones = ['user@example.com', '1231231231'];
    final correctPassword = 'password123';

    if (validEmailsOrPhones.contains(emailOrPhone)) {
      if (password == correctPassword) {
        context.router.replaceNamed('/bottom_navigation');
      } else {
        setState(() {
          _isPasswordError = true;
          _errorMessage = S.of(context)!.incorrect_password;
        });
      }
    } else {
      setState(() {
        _isEmailOrPhoneError = true;
        _errorMessage = S.of(context)!.user_not_found_prompt;
      });
    }
  }

  void _clearEmailOrPhoneError() {
    if (_isEmailOrPhoneError) {
      setState(() {
        _isEmailOrPhoneError = false;
        _errorMessage = null;
      });
    }
  }

  void _clearPasswordError() {
    if (_isPasswordError) {
      setState(() {
        _isPasswordError = false;
        _errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
      ),
      backgroundColor: maincolor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context)!.welcome,
                  style: TextStyle(
                    color: fontcolor,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  S.of(context)!.login_description,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: fontcolor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.0),
                Image.asset('lib/assets/icon/home.png',
                    height: 214, width: 214),
                SizedBox(height: 24.0),
                CustomTextField(
                  controller: _emailOrPhoneController,
                  labelText: S.of(context)!.email_or_phone,
                  prefixIcon: Icons.person_outline,
                  suffixIcon: Icons.clear,
                  obscureText: false,
                  isError: _isEmailOrPhoneError,
                  errorMessage: S.of(context)!.user_not_found_prompt,
                  onSuffixIconPressed: () {
                    _emailOrPhoneController.clear();
                  },
                  onChanged: (value) => _clearEmailOrPhoneError(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context)!.user_not_found_prompt;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  controller: _passwordController,
                  labelText: S.of(context)!.password,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon:
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                  obscureText: _obscureText,
                  isError: _isPasswordError,
                  errorMessage: S.of(context)!.incorrect_password,
                  onSuffixIconPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  onChanged: (value) => _clearPasswordError(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context)!.incorrect_password;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: TextButton(
                      onPressed: () => context.router.replaceNamed('/forgot'),
                      child: Text(
                        S.of(context)!.forgot_password,
                        style:
                            TextStyle(color: unnecessary_colors, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                CustomButton(
                  text: S.of(context)!.sign_in,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context)!.no_account_prompt,
                          style: TextStyle(
                            color: unnecessary_colors,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.router.replaceNamed('/signup'),
                          child: Text(
                            S.of(context)!.sign_up,
                            style: TextStyle(
                                color: fontcolor,
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: GestureDetector(
                      onTap: _changeLanguage,
                      child: Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 26,
                            decoration: BoxDecoration(
                              color: fill_color,
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            left: isEnglish ? 0 : 24,
                            right: isEnglish ? 24 : 0,
                            child: Flag.fromString(
                              isEnglish ? 'GB' : 'TH',
                              height: 26,
                              width: 26,
                              fit: BoxFit.cover,
                              flagSize: FlagSize.size_1x1,
                              borderRadius: 13,
                            ),
                          ),
                          Positioned(
                            left: isEnglish ? 30 : 5,
                            top: 4,
                            child: Text(
                              isEnglish ? "EN" : "TH",
                              style: TextStyle(
                                color: fontcolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
