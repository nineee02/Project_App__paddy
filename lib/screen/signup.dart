import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

const List<String> county = <String>['Thailand', 'Laos'];

@RoutePage()
class SignupRoute extends StatelessWidget {
  const SignupRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: (IconButton(
            onPressed: () {
              context.router.replaceNamed('/login');
            },
            icon: Icon(Icons.arrow_back))),
        title: Text(
          "Create account",
          style: TextStyle(
              color: Color.fromRGBO(77, 22, 0, 1),
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  cursorColor: Color.fromRGBO(77, 22, 0, 1),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: Color.fromRGBO(77, 22, 0, 1),
                    ),
                    labelText: "Name",
                    hintText: "Enter your name",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(255, 255, 244, 1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(77, 22, 0, 1),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: Color.fromRGBO(77, 22, 0, 1),
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Surname",
                    hintText: "Enter your Surname",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(255, 255, 244, 1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(77, 22, 0, 1),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color.fromRGBO(77, 22, 0, 1),
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Email",
                    hintText: "Enter your Email",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(255, 255, 244, 1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(77, 22, 0, 1),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: Color.fromRGBO(77, 22, 0, 1),
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Phone number",
                    hintText: "Enter your Phone number",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(255, 255, 244, 1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(77, 22, 0, 1),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color.fromRGBO(77, 22, 0, 1),
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Password",
                    hintText: "Enter your Password",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(255, 255, 244, 1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(77, 22, 0, 1),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color.fromRGBO(77, 22, 0, 1),
                    ),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Confirm Password",
                    hintText: "Enter your Confirm Password",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(121, 121, 121, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(255, 255, 244, 1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(77, 22, 0, 1),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0))),
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                ListTile(
                                  title: Text("Select country"),
                                ),
                                // _buildCountryListTile(context, "Thailand"),
                                // _buildCountryListTile(context, "Laos"),
                              ],
                            ),
                          );
                        });
                  },
                  child: const Text(
                    "Select County",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(121, 121, 121, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home_outlined),
                    suffixIcon: Icon(Icons.expand_more),
                    labelText: "Province",
                    hintText: "Select Province",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    //helperText: 'supporting text',
                    border: OutlineInputBorder(),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home_outlined),
                    suffixIcon: Icon(Icons.expand_more),
                    labelText: "District",
                    hintText: "Select District",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    //helperText: 'supporting text',
                    border: OutlineInputBorder(),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home_outlined),
                    suffixIcon: Icon(Icons.expand_more),
                    labelText: "County",
                    hintText: "Select County",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    //helperText: 'supporting text',
                    border: OutlineInputBorder(),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      5.0), // Add border radius for rounded corners
                  border: Border.all(
                    color: Color.fromRGBO(77, 22, 0, 1), // Set border color
                    width: 1.0, // Set border width
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      child: DropdownButton<String>(
                        items: county.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search, // Replace with the desired icon
                                  color: Color.fromRGBO(
                                      77, 22, 0, 1), // Set icon color
                                ),
                                SizedBox(width: 10.0),
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Handle selection change
                        },
                        hint: Text('County'), // Adjust hint text as needed
                        underline: Container(), // Remove default underline
                      ),
                    )
                  ],
                ),
                // child: DropdownButton<String>(
                //   items: county.map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     // setState(() {});
                //   },
                //   hint: Text('Select County'),
                // ),
              ),
              Container(
                width: 312,
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home_outlined),
                    // suffixIcon: Icon(Icons.clear),
                    labelText: "Postal code",
                    hintText: "Enter your Postal code",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(77, 22, 0, 1), fontSize: 16),
                    fillColor: Color.fromRGBO(255, 255, 244, 1),
                    //helperText: 'supporting text',
                    border: OutlineInputBorder(),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 244, 1),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 312,
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(255, 222, 47, 1),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.router.replaceNamed('/login');
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Color.fromRGBO(77, 22, 0, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 64,
              )
            ],
          ),
        ),
      ),
    );
  }
}
