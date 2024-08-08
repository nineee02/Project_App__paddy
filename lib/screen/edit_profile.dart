import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';

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

  Color _labelColor = Colors.grey;

  @override
  void initState() {
    super.initState();

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
          onPressed: () => context.router.replaceNamed('/bottom_navigation'),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                CustomButton(
                  text: "Save Changes",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Implement save changes functionality here
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
