import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

@RoutePage()
class OtpRoute extends StatelessWidget {
  final String inputType;
  final String inputValue;

  const OtpRoute({
    Key? key,
    required this.inputType,
    required this.inputValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _pinController = TextEditingController();
    String contactInfo = inputType == 'phone' ? inputValue : inputValue;

    void _verifyOtp() {
      if (_pinController.text.length == 4) {
        print('OTP verification button pressed');
        context.router.pushNamed('/change_password');
      } else {
        print('Invalid OTP length');
      }
    }

    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconcolor),
          onPressed: () => context.router.replaceNamed('/forgot'),
        ),
        title: Text(
          "Verify $inputType",
          style: appBarFont,
        ),
        centerTitle: true,
      ),
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
                  opacity: 0.5,
                  image: AssetImage('lib/assets/icon/home.png'),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "We have sent the code verification \nto $contactInfo.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: fontcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 72.0),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4,
                          controller: _pinController,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeColor: Colors.white,
                            selectedColor: iconcolor,
                            inactiveColor: Colors.grey,
                            activeFillColor: fill_color,
                            selectedFillColor: fill_color,
                            inactiveFillColor: fill_color,
                          ),
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            ),
                          ],
                          onChanged: (value) {},
                          enableActiveFill: true,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            print('Resend OTP button pressed');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'OTP resent successfully (simulated).')),
                            );
                          },
                          child: Text(
                            "Didn't receive the OTP? Resend code",
                            style: TextStyle(
                              color: unnecessary_colors,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Center(
                        child: CustomButton(
                            text: "Verify and Create Password",
                            onPressed: () {
                              context.router.replaceNamed('/change_password');
                            }
                            // _verifyOtp,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
