import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_route/auto_route.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/main.dart';
import 'package:paddy_rice/widgets/shDialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  String name;
  String surname;
  String email;

  UserProfile({
    required this.name,
    required this.surname,
    required this.email,
    required String phone,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        name: json['name'],
        surname: json['surname'],
        email: json['email'],
        phone: json['phone_number']);
  }
}

@RoutePage()
class ProfileRoute extends StatefulWidget {
  const ProfileRoute({super.key});

  @override
  _ProfileRouteState createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  late Future<UserProfile> _userProfile;
  // final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    // _userProfile = _fetchUserProfile();
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
      body: FutureBuilder<UserProfile>(
        future: _userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(iconcolor)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ProfileContent(
                user: snapshot.data!, onLogout: _showLogoutDialog);
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShDialog(
          title: S.of(context)!.log_out,
          content: S.of(context)!.logout_confirmation,
          parentContext: context,
          confirmButtonText: S.of(context)!.log_out,
          cancelButtonText: S.of(context)!.cancel,
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
            padding: const EdgeInsets.only(right: 288, bottom: 8),
            child: Text(
              S.of(context)!.account,
              style: TextStyle(
                  color: fontcolor, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: fill_color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: iconcolor),
                  title: Text(
                    S.of(context)!.personal_settings,
                    style: TextStyle(fontSize: 16, color: fontcolor),
                  ),
                  trailing: Icon(Icons.chevron_right, color: iconcolor),
                  onTap: () => context.router.replaceNamed('/edit_profile'),
                ),
                ListTile(
                  leading: Icon(Icons.lock, color: iconcolor),
                  title: Text(
                    S.of(context)!.change_password,
                    style: TextStyle(fontSize: 16, color: fontcolor),
                  ),
                  trailing: Icon(Icons.chevron_right, color: iconcolor),
                  onTap: () =>
                      context.router.replaceNamed('/change_password_profile'),
                ),
                LanguageChangeTile(),
              ],
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: fill_color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(Icons.logout, color: error_color),
              title: Text(
                S.of(context)!.log_out,
                style: TextStyle(color: error_color, fontSize: 16),
              ),
              onTap: () => onLogout(context),
            ),
          ),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  final UserProfile user;
  ProfileHeader({required this.user});

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String? _imagePath;

  void _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
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
          color: fill_color,
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
                        image: _imagePath != null
                            ? FileImage(File(_imagePath!))
                            : AssetImage('lib/assets/icon/home.png')
                                as ImageProvider,
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
                      "${widget.user.name} ${widget.user.surname}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: fontcolor),
                    ),
                    Text(widget.user.email,
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
      color: fill_color,
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
