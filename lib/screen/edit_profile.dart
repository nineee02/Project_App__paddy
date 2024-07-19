import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  String? originalName;
  String? originalSurname;
  String? originalEmail;
  String? originalPhone;

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
          "Edit profile",
          style: TextStyle(
              color: fontcolor, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(labelText: 'Surname'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateProfile();
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
