import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/constants/api.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/shDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfile {
  final String name;
  final String surname;
  final String email;
  final String phone;

  UserProfile({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['Name'],
      surname: json['Surname'],
      email: json['Email'],
      phone: json['PhoneNumber'],
    );
  }
}

Future<UserProfile> fetchUserProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getInt('userId');
  if (userId == null) {
    throw Exception('No user ID found');
  }

  final response = await http.get(
    Uri.parse('${ApiConstants.baseUrl}/profile/$userId'),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return UserProfile.fromJson(json.decode(response.body));
  } else {
    print('Error: ${response.statusCode}');
    throw Exception('Failed to load user profile');
  }
}

@RoutePage()
class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShDialog(
          title: 'Log Out',
          content: 'Are you sure you want to log out?',
          parentContext: context,
          confirmButtonText: 'OK',
          cancelButtonText: 'Not Now',
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
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text("My Profile", style: appBarFont),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        selectedItemColor: Colors.grey[400],
        unselectedItemColor: iconcolor,
        onTap: (int index) {
          if (index == 0) {
            context.router.replaceNamed('/home');
          } else {
            context.router.replaceNamed('/profile');
          }
        },
      ),
      body: FutureBuilder<UserProfile>(
        future: fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red)),
            );
          } else if (!snapshot.hasData) {
            return Center(child: Text('No profile data found'));
          } else {
            final user = snapshot.data!;
            return ProfileContent(user: user, onLogout: _showLogoutDialog);
          }
        },
      ),
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
        children: [
          ProfileHeader(user: user),
          ListTile(
            leading: Icon(Icons.email, color: iconcolor),
            title: Text(user.email, style: bodyFont),
            trailing: Icon(Icons.chevron_right, color: iconcolor),
          ),
          ChangePasswordTile(),
          Divider(color: unnecessary_colors),
          ListTile(
            leading: Icon(Icons.logout, color: iconcolor),
            title: Text("Log out", style: bodyFont),
            trailing: Icon(Icons.chevron_right, color: iconcolor),
            onTap: () => onLogout(context),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final UserProfile user;
  ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.replaceNamed('/edit_profile'),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: maincolor,
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 40),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${user.name} ${user.surname}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: fontcolor)),
                    Text(user.email,
                        style:
                            TextStyle(fontSize: 14, color: unnecessary_colors)),
                  ],
                ),
              ),
            ),
            Icon(Icons.edit, color: iconcolor),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordTile extends StatefulWidget {
  @override
  _ChangePasswordTileState createState() => _ChangePasswordTileState();
}

class _ChangePasswordTileState extends State<ChangePasswordTile> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isCurrentPasswordObscured = true;
  bool _isNewPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isPasswordError = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.lock, color: iconcolor),
      title: Text("Change Password",
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
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                _buildPasswordField(
                  controller: _currentPasswordController,
                  labelText: "Current Password",
                  isObscured: _isCurrentPasswordObscured,
                  onToggle: () {
                    setState(() => _isCurrentPasswordObscured =
                        !_isCurrentPasswordObscured);
                  },
                  isError: false,
                  errorMessage: '',
                ),
                SizedBox(height: 20),
                _buildPasswordField(
                  controller: _newPasswordController,
                  labelText: "New Password",
                  isObscured: _isNewPasswordObscured,
                  onToggle: () {
                    setState(
                        () => _isNewPasswordObscured = !_isNewPasswordObscured);
                  },
                  isError: false,
                  errorMessage: '',
                ),
                SizedBox(height: 20),
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  labelText: "Confirm New Password",
                  isObscured: _isConfirmPasswordObscured,
                  onToggle: () {
                    setState(() => _isConfirmPasswordObscured =
                        !_isConfirmPasswordObscured);
                  },
                  isError: _isPasswordError,
                  errorMessage: _errorMessage,
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: "Change Password",
                  onPressed: () {
                    context.router.replaceNamed('/profile');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required bool isObscured,
    required VoidCallback onToggle,
    required bool isError,
    required String errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 312,
          height: 48,
          child: TextFormField(
            controller: controller,
            obscureText: isObscured,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: fontcolor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorder_color),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorder_color),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility : Icons.visibility_off,
                  color: iconcolor,
                ),
                onPressed: onToggle,
              ),
            ),
          ),
        ),
        if (isError)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
