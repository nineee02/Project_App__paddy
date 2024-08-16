import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/router/routes.gr.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/decorated_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// User Profile Model
class UserProfile {
  String name, surname, email, phone;

  UserProfile({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      phone: json['phone_number'],
    );
  }
}

// Edit Profile Route
@RoutePage()
class EditProfileRoute extends StatefulWidget {
  const EditProfileRoute({super.key});

  @override
  _EditProfileRouteState createState() => _EditProfileRouteState();
}

class _EditProfileRouteState extends State<EditProfileRoute> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameFocusNode = FocusNode();
  bool isLoading = false;
  String? _imagePath;

  bool _isNameError = false;
  bool _isSurnameError = false;
  bool _isEmailError = false;
  bool _isPhoneError = false;

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() => setState(() {}));
    // _fetchUserProfile();
  }

  // Fetch user profile data from API
  // Future<void> _fetchUserProfile() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.getInt('userId');
  //   if (userId == null) throw Exception('No user ID found');

  //   final response =
  //       await http.get(Uri.parse('${ApiConstants.baseUrl}/profile/$userId'));

  //   if (response.statusCode == 200) {
  //     final profile = UserProfile.fromJson(jsonDecode(response.body));
  //     _nameController.text = profile.name;
  //     _surnameController.text = profile.surname;
  //     _emailController.text = profile.email;
  //     _phoneController.text = profile.phone;
  //   } else {
  //     throw Exception('Failed to load profile');
  //   }
  // }

  // Validate fields before saving
  bool _validateFields() {
    return _nameController.text.trim().isNotEmpty &&
        _surnameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty;
  }

  // Save changes
  Future<void> _onSaveChanges() async {
    if (_formKey.currentState!.validate()) {
      // Trigger validation of the form
      setState(() => isLoading = true);
      await Future.delayed(const Duration(seconds: 2)); // Simulate save action
      setState(() => isLoading = false);
      // Implement save changes functionality here
    } else {}
  }

  InputDecoration _buildInputDecoration(
      String label, Color labelColor, bool isError) {
    return InputDecoration(
      filled: true,
      fillColor: fill_color,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      labelText: label,
      labelStyle: TextStyle(
        color: isError
            ? error_color
            : labelColor, // Set label color to red if there's an error
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: error_color, width: 1), // Red border when there's an error
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: error_color, width: 1), // Red border when focused with error
        borderRadius: BorderRadius.circular(8),
      ),
      errorStyle: TextStyle(
          color: error_color, fontSize: 12), // Set error message color to red
    );
  }

  // Build profile text fields
  List<Widget> _buildTextFields(Color labelColor) {
    return [
      _buildTextField(
        _nameController,
        S.of(context)!.name,
        labelColor,
        (value) {
          if (value == null || value.trim().isEmpty) {
            return S
                .of(context)!
                .name_error; // "Name must be at least 2 characters long"
          } else if (value.length < 2) {
            return S.of(context)!.name_error;
          }
          return null;
        },
      ),
      _buildTextField(
        _surnameController,
        S.of(context)!.surname,
        labelColor,
        (value) {
          if (value == null || value.trim().isEmpty) {
            return S
                .of(context)!
                .surname_error; // "Surname must be at least 2 characters long"
          } else if (value.length < 2) {
            return S.of(context)!.surname_error;
          }
          return null;
        },
      ),
      _buildTextField(
        _emailController,
        S.of(context)!.email,
        labelColor,
        (value) {
          if (value == null || value.trim().isEmpty) {
            return S.of(context)!.email_error; // "Invalid email format"
          } else if (!RegExp(
                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
              .hasMatch(value)) {
            return S.of(context)!.email_error;
          }
          return null;
        },
      ),
      _buildTextField(
        _phoneController,
        S.of(context)!.phone,
        labelColor,
        (value) {
          if (value == null || value.trim().isEmpty) {
            return S
                .of(context)!
                .phone_error; // "Phone number must be 10 digits"
          } else if (value.length != 10) {
            return S.of(context)!.phone_error;
          }
          return null;
        },
      ),
    ];
  }

  // Build each text field widget
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    Color labelColor,
    String? Function(String?)?
        validator, // Pass a validator function as a parameter
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: 312,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode
              .onUserInteraction, // Enable validation on user interaction
          decoration: _buildInputDecoration(label, labelColor, false),
          validator: validator, // Use the passed validator function
        ),
      ),
    );
  }

  void _updateButtonState() {
    setState(() {
      bool isValid = _nameController.text.trim().isNotEmpty &&
          _surnameController.text.trim().isNotEmpty &&
          _emailController.text.trim().isNotEmpty &&
          _phoneController.text.trim().isNotEmpty;

      isLoading = !isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelColor =
        _nameFocusNode.hasFocus ? focusedBorder_color : Colors.grey;

    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconcolor),
          onPressed: () =>
              context.router.replace(BottomNavigationRoute(page: 1)),
        ),
        title: Text(S.of(context)!.edit_profile, style: appBarFont),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          DecoratedImage(),
          Column(
            children: [
              Center(
                child: Stack(
                  alignment:
                      Alignment.bottomRight, // จัดไอคอนให้อยู่มุมขวาล่างของรูป
                  children: [
                    GestureDetector(
                      onTap: () {
                        _openGallery(context); // เปิดแกลเลอรีเมื่อผู้ใช้กด
                      },
                      child: Container(
                        width: 100,
                        height: 100,
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
              ),
              const SizedBox(height: 16), // เพิ่มระยะห่าง
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          ..._buildTextFields(labelColor),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: S.of(context)!.save_changes,
                            onPressed: _onSaveChanges,
                            isLoading: isLoading,
                          ),
                        ],
                      ),
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

  void _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        // Store the image path for use
        _imagePath = image.path;
      });
      print('Selected image path: ${image.path}');
    }
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
}
