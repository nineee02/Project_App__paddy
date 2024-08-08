import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_route/auto_route.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/main.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/CustomTextField.dart';
import 'package:paddy_rice/widgets/CustomTextFieldNoiconfront.dart';
import 'package:paddy_rice/widgets/shDialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfile {
  String name;
  String surname;
  String email;
  String phone;

  UserProfile({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
  });
}

@RoutePage()
class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShDialog(
          title: S.of(context)!.log_out,
          content: S.of(context)!.logout_confirmation,
          parentContext: context,
          confirmButtonText: S.of(context)!.ok,
          cancelButtonText: S.of(context)!.not_now,
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

  @override
  Widget build(BuildContext context) {
    final user = UserProfile(
      name: 'John',
      surname: 'Doe',
      email: 'john.doe@example.com',
      phone: '123-456-7890',
    );

    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(S.of(context)!.my_profile, style: appBarFont),
        centerTitle: true,
        elevation: 0,
      ),
      body: ProfileContent(user: user, onLogout: _showLogoutDialog),
    );
  }
}

class ProfileContent extends StatelessWidget {
  final UserProfile user;
  final Function(BuildContext) onLogout;

  ProfileContent({required this.user, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProfileHeader(user: user),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 288),
            child: Text(
              S.of(context)!.account,
              style: TextStyle(
                  color: fontcolor, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: iconcolor),
            title: Text(
              S.of(context)!.personal_settings,
              style: TextStyle(fontSize: 16, color: fontcolor),
            ),
            trailing: Icon(Icons.chevron_right, color: iconcolor),
            onTap: () => _showEditProfileSheet(context, user),
          ),
          ChangePasswordTile(),
          LanguageChangeTile(),
          const SizedBox(
            height: 16.0,
          ),
          Divider(color: unnecessary_colors),
          const SizedBox(
            height: 16.0,
          ),
          ListTile(
            leading: Icon(Icons.logout, color: iconcolor),
            title: Text(
              S.of(context)!.log_out,
              style: TextStyle(color: error_color, fontSize: 16),
            ),
            onTap: () => onLogout(context),
          ),
        ],
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context, UserProfile user) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: maincolor,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context)!.edit_profile,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: fontcolor),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: iconcolor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: TextEditingController(text: user.name),
                  labelText: S.of(context)!.name,
                  obscureText: false,
                  suffixIcon: Icons.clear,
                  onSuffixIconPressed: () {},
                  isError: false,
                  // errorMessage: '',
                  prefixIcon: Icons.person_outline,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: TextEditingController(text: user.surname),
                  labelText: S.of(context)!.surname,
                  obscureText: false,
                  suffixIcon: Icons.clear,
                  onSuffixIconPressed: () {},
                  isError: false,
                  // errorMessage: '',
                  prefixIcon: Icons.person_outline,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: TextEditingController(text: user.email),
                  labelText: S.of(context)!.email,
                  obscureText: false,
                  suffixIcon: Icons.clear,
                  onSuffixIconPressed: () {},
                  isError: false,
                  // errorMessage: '',
                  prefixIcon: Icons.email_outlined,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: TextEditingController(text: user.phone),
                  labelText: S.of(context)!.phone,
                  obscureText: false,
                  suffixIcon: Icons.clear,
                  onSuffixIconPressed: () {},
                  isError: false,
                  // errorMessage: '',
                  prefixIcon: Icons.phone_outlined,
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: S.of(context)!.save_changes,
                  onPressed: () {
                    if (_validateProfile(user, context)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context)!.profile_updated),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _validateProfile(UserProfile user, BuildContext context) {
    if (user.name.isEmpty ||
        user.surname.isEmpty ||
        user.email.isEmpty ||
        user.phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)!.fill_out_fields)),
      );
      return false;
    }

    // Add any other validation logic as needed

    return true;
  }
}

class ProfileHeader extends StatelessWidget {
  final UserProfile user;
  ProfileHeader({required this.user});

  void _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print('Selected image path: ${image.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: maincolor,
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                InkWell(
                  onTap: () => _openGallery(context),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage('lib/assets/icon/home.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: maincolor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: iconcolor,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.name} ${user.surname}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: fontcolor),
                    ),
                    Text(user.email,
                        style:
                            TextStyle(fontSize: 14, color: unnecessary_colors)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageChangeTile extends StatefulWidget {
  @override
  _LanguageChangeTileState createState() => _LanguageChangeTileState();
}

class _LanguageChangeTileState extends State<LanguageChangeTile> {
  Locale? _currentLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentLocale = Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.language, color: fontcolor),
      title: Text(S.of(context)!.language,
          style: TextStyle(color: fontcolor, fontSize: 16)),
      trailing: Icon(Icons.chevron_right, color: iconcolor),
      onTap: () => _showLanguageChangeSheet(context),
    );
  }

  void _showLanguageChangeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildLanguageOption("English", Locale('en')),
            _buildLanguageOption("ไทย", Locale('th')),
          ],
        );
      },
    );
  }

  Widget _buildLanguageOption(String language, Locale locale) {
    return Container(
      color: maincolor,
      child: ListTile(
        leading: Icon(Icons.language, color: iconcolor),
        title: Text(language, style: TextStyle(color: fontcolor)),
        trailing: _currentLocale == locale
            ? Icon(Icons.check, color: iconcolor)
            : null,
        onTap: () {
          _changeLanguage(locale);
        },
      ),
    );
  }

  void _changeLanguage(Locale locale) {
    if (locale != _currentLocale) {
      setState(() {
        _currentLocale = locale;
        MyApp.setLocale(context, locale);
      });
      Navigator.of(context).pop();
    }
  }
}

class ChangePasswordTile extends StatefulWidget {
  @override
  _ChangePasswordTileState createState() => _ChangePasswordTileState();
}

class _ChangePasswordTileState extends State<ChangePasswordTile> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isCurrentPasswordObscured = true;
  bool _isNewPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isPasswordError = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.lock, color: iconcolor),
      title: Text(S.of(context)!.change_password,
          style: TextStyle(color: fontcolor, fontSize: 16)),
      trailing: Icon(Icons.chevron_right, color: iconcolor),
      onTap: () => _showChangePasswordSheet(context),
    );
  }

  void _showChangePasswordSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: maincolor,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context)!.change_password,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: fontcolor),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: iconcolor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextFieldCustom(
                  controller: _currentPasswordController,
                  labelText: S.of(context)!.current_password,
                  suffixIcon: _isCurrentPasswordObscured
                      ? Icons.visibility
                      : Icons.visibility_off,
                  obscureText: _isCurrentPasswordObscured,
                  onSuffixIconPressed: () {
                    setState(() {
                      _isCurrentPasswordObscured = !_isCurrentPasswordObscured;
                    });
                  },
                  isError: false,
                  errorMessage: '',
                ),
                SizedBox(height: 20),
                TextFieldCustom(
                  controller: _newPasswordController,
                  labelText: S.of(context)!.new_password,
                  suffixIcon: _isNewPasswordObscured
                      ? Icons.visibility
                      : Icons.visibility_off,
                  obscureText: _isNewPasswordObscured,
                  onSuffixIconPressed: () {
                    setState(() {
                      _isNewPasswordObscured = !_isNewPasswordObscured;
                    });
                  },
                  isError: false,
                  errorMessage: '',
                ),
                SizedBox(height: 20),
                TextFieldCustom(
                  controller: _confirmPasswordController,
                  labelText: S.of(context)!.confirm_new_password,
                  suffixIcon: _isConfirmPasswordObscured
                      ? Icons.visibility
                      : Icons.visibility_off,
                  obscureText: _isConfirmPasswordObscured,
                  onSuffixIconPressed: () {
                    setState(() {
                      _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                    });
                  },
                  isError: _isPasswordError,
                  errorMessage: _errorMessage,
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: S.of(context)!.reset,
                  onPressed: () {
                    _validatePasswords(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _validatePasswords(BuildContext context) {
    setState(() {
      _isPasswordError = false;
      _errorMessage = '';

      if (_currentPasswordController.text.isEmpty ||
          _newPasswordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty) {
        _isPasswordError = true;
        _errorMessage = S.of(context)!.fill_out_fields;
      } else if (_newPasswordController.text !=
          _confirmPasswordController.text) {
        _isPasswordError = true;
        _errorMessage = S.of(context)!.passwords_do_not_match;
      } else {
        // Simulate password change success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)!.password_reset_successful)),
        );
        Navigator.of(context).pop();
        context.router.replaceNamed('/bottom_navigation');
      }
    });
  }
}
