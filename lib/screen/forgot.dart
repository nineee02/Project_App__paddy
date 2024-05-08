import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

final List<String> select_Value = [
  'Phone number',
  'Email',
];

@RoutePage()
class ForgotRoute extends StatefulWidget {
  const ForgotRoute({Key? key}) : super(key: key);

  @override
  _ForgotRouteState createState() => _ForgotRouteState();
}

class _ForgotRouteState extends State<ForgotRoute> {
  String? selectedValue = "Phone number";
  String hintText = "Please enter your Email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () {
            context.router.replaceNamed('/login');
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Reset password",
          style: TextStyle(
            color: fontcolor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: maincolor,
      body: Stack(
        children: [
          Positioned(
            bottom: -135,
            left: (MediaQuery.of(context).size.width - 456) / 2,
            child: Container(
              width: 456,
              height: 456,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/icon/home.png'),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      items: select_Value
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style:
                                      TextStyle(fontSize: 16, color: fontcolor),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                          if (value == 'Phone number') {
                            hintText = "Please enter your phone number";
                          } else {
                            hintText = "Please enter your Email";
                          }
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 48,
                        width: 312,
                        decoration: BoxDecoration(
                          color: fill_color,
                        ),
                      ),
                      iconStyleData: IconStyleData(
                          icon: Icon(Icons.unfold_more_rounded),
                          iconSize: 24,
                          iconEnabledColor: iconcolor),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: fill_color,
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                selectedValue == 'Phone number'
                    ? Container(
                        width: 312,
                        child: IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(121, 121, 121, 1),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(121, 121, 121, 1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  // width: 1,
                                  // color: Color.fromRGBO(121, 121, 121, 1),
                                  ),
                            ),
                          ),
                          initialCountryCode: 'TH',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                      )
                    : Container(
                        width: 312,
                        height: 48,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: hintText,
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(121, 121, 121, 1),
                              fontSize: 16,
                            ),
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(121, 121, 121, 1),
                              fontSize: 16,
                            ),
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
                SizedBox(height: 16),
                Container(
                  width: 312,
                  height: 48,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttoncolor),
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
