import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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

  // Factory method สำหรับแปลง JSON เป็น Object
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class UserProfileService {
  static const String baseUrl = 'http://10.0.2.2:3000/profile';
  // เรียกใช้ข้อมูลผู้ใช้จาก server
  static Future<UserProfile> fetchUserProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/profile'));

    if (response.statusCode == 200) {
      // ถ้า response สำเร็จ
      // แปลงข้อมูล JSON เป็น Object UserProfile
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      // ถ้า response ไม่สำเร็จ
      throw Exception('Failed to load user profile');
    }
  }
}

@RoutePage()
class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? user =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(
          "My Profile",
          style: TextStyle(
              color: fontcolor, fontSize: 22, fontWeight: FontWeight.bold),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
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
                                "${user?['name']} ${user?['surname']}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: fontcolor),
                              ),
                              Text(
                                "Senior Designer",
                                style: TextStyle(
                                    fontSize: 16, color: unnecessary_colors),
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
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.wallet_giftcard, color: Colors.green),
              title: Text("My Wallet"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.card_membership, color: Colors.blue),
              title: Text("Payments"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text("Settings"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () => context.router.replaceNamed('/login'),
              child: Text('Log Out'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
