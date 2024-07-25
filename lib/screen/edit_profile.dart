import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paddy_rice/constants/font_size.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paddy_rice/constants/api.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class EditProfileRoute extends StatefulWidget {
  const EditProfileRoute({super.key});

  @override
  _EditProfileRouteState createState() => _EditProfileRouteState();
}

class _EditProfileRouteState extends State<EditProfileRoute> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();

  String? originalName;
  String? originalSurname;
  String? originalEmail;
  String? originalPhone;
  Color _labelColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _loadUserData();

    _nameFocusNode.addListener(() {
      setState(() {
        _labelColor = _nameFocusNode.hasFocus ? focusedBorder_color : fontcolor;
      });
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      originalName = prefs.getString('name');
      originalSurname = prefs.getString('surname');
      originalEmail = prefs.getString('email');
      originalPhone = prefs.getString('phone');

      _nameController.text = originalName ?? '';
      _surnameController.text = originalSurname ?? '';
      _emailController.text = originalEmail ?? '';
      _phoneController.text = originalPhone ?? '';
    });
  }

  Future<void> _updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    if (userId == null) {
      throw Exception('No user ID found');
    }

    Map<String, String> updatedFields = {};

    if (_nameController.text != originalName) {
      updatedFields['name'] = _nameController.text;
    }
    if (_surnameController.text != originalSurname) {
      updatedFields['surname'] = _surnameController.text;
    }
    if (_emailController.text != originalEmail) {
      updatedFields['email'] = _emailController.text;
    }
    if (_phoneController.text != originalPhone) {
      updatedFields['phone'] = _phoneController.text;
    }

    if (updatedFields.isEmpty) {
      print('No changes to update');
      return;
    }

    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/edit_profile/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedFields),
    );

    if (response.statusCode == 200) {
      print('Profile updated successfully');
      // Update the local storage
      updatedFields.forEach((key, value) async {
        await prefs.setString(key, value);
      });
      context.router.replaceNamed('/profile');
    } else {
      print('Failed to update profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: iconcolor,
          ),
          onPressed: () => context.router.replaceNamed('/profile'),
        ),
        title: Text(
          "Edit Profile",
          style: appBarFont,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Implement photo upload functionality here
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.camera_alt,
                      size: 32,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: 312,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    focusNode: _nameFocusNode,
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fill_color,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: _labelColor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: error_color, width: 1),
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
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 312,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _surnameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fill_color,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      labelText: 'Surname',
                      labelStyle: TextStyle(color: fontcolor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: error_color, width: 1),
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
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 312,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fill_color,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: fontcolor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: error_color, width: 1),
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
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 312,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: fill_color,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: fontcolor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: error_color, width: 1),
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
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateProfile();
                    }
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: fontcolor,
                    backgroundColor: buttoncolor,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
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
