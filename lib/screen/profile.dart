import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/constants/api.dart';
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
        title: Text(
          "My Profile",
          style: appBarFont,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        selectedItemColor: Colors.grey[400],
        unselectedItemColor: iconcolor,
        onTap: (int index) {
          if (index == 0) {
            context.router.replaceNamed('/home');
          } else if (index == 1) {
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
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(child: Text('No profile data found'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => context.router.replaceNamed('/edit_profile'),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: maincolor,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              // backgroundImage:
                              //     NetworkImage('https://via.placeholder.com/150'),
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
                                    Text(
                                      "${user.email}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: unnecessary_colors),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(Icons.edit, color: iconcolor), // Example icon
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.email, color: iconcolor),
                    title: Text(
                      user.email,
                      style: bodyFont,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: iconcolor,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.phone, color: iconcolor),
                    title: Text(
                      user.phone,
                      style: bodyFont,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: iconcolor,
                    ),
                    onTap: () {},
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 253, 253),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => _showLogoutDialog(context),
                    child: Text('Log Out'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
