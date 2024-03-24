import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paddy_rice/constants/color.dart';
// import 'package:dropdown_below/dropdown_below.dart';

// import 'package:flutter_launcher_icons/main.dart';
// import 'package:paddy_rice/l10n/locali18n.dart';

@RoutePage()
class ForgotRoute extends StatelessWidget {
  const ForgotRoute({super.key});

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Phone number';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: (IconButton(
            onPressed: () {
              context.router.replaceNamed('/login');
            },
            icon: Icon(Icons.arrow_back))),
        title: Text(
          "Reset password",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: maincolor,
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: 312,
            height: 48,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                filled: true,
                fillColor: Color.fromRGBO(255, 255, 244, 1),
              ),
              dropdownColor: Color.fromRGBO(255, 255, 244, 1),
              value: dropdownValue,
              onChanged: (String? newValue) {
                // setState(() {
                //   dropdownValue = newValue!;
                // });
              },
              items: <String>['Phone number', 'Email']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(77, 22, 0, 1),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 312,
            height: 48,
            child: TextField(
              decoration: InputDecoration(
                // prefixIcon: Icon(
                //   Icons.lock_outline,
                //   color: Color.fromRGBO(77, 22, 0, 1),
                // ),
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
            height: 16,
          ),
          Container(
            width: 312,
            height: 48,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  buttoncolor,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              onPressed: () {
                context.router.replaceNamed('/otp');
              },
              child: Text(
                "Next",
                style: TextStyle(
                    color: fontcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            width: 456,
            height: 456,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 244, 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/icon/home.png',
                  width: 338,
                  height: 338,
                ),
                // SizedBox(width: 8.0),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
