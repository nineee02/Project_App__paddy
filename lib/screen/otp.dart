import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// import 'package:paddy_rice/constants/api.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

@RoutePage()
class OtpRoute extends StatelessWidget {
  final String inputType;
  final String inputValue;

  const OtpRoute({
    Key? key,
    required this.inputType,
    required this.inputValue,
  }) : super(key: key);

  // Future<void> resendOtp(BuildContext context) async {
  //   final String apiUrl =
  //       '${ApiConstants.baseUrl}/resend_otp'; // Adjust URL as needed
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'contact': inputValue, 'type': inputType}),
  //     );

  //     if (response.statusCode == 200) {
  //       print("OTP resent successfully.");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('OTP resent successfully.')),
  //       );
  //     } else {
  //       print("Failed to resend OTP. Status code: ${response.statusCode}");
  //       print("Response body: ${response.body}");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to resend OTP.')),
  //       );
  //     }
  //   } catch (e) {
  //     print("Error occurred: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error occurred while resending OTP.')),
  //     );
  //   }
  // }

  // Future<void> verifyOtp(BuildContext context, String otp) async {
  //   final String apiUrl =
  //       '${ApiConstants.baseUrl}/verify_otp'; // Adjust URL as needed
  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body:
  //           jsonEncode({'otp': otp, 'contact': inputValue, 'type': inputType}),
  //     );

  //     if (response.statusCode == 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('OTP verified successfully.')),
  //       );
  //       context.router.replaceNamed('/change_password');
  //     } else {
  //       print("Failed to verify OTP. Status code: ${response.statusCode}");
  //       print("Response body: ${response.body}");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to verify OTP.')),
  //       );
  //     }
  //   } catch (e) {
  //     print("Error occurred: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error occurred while verifying OTP.')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController _pinController = TextEditingController();
    String contactInfo = inputType == 'phone' ? inputValue : inputValue;

    void _verifyOtp() {
      if (_pinController.text.length == 4) {
        // Replace with actual verification logic
        print('OTP verification button pressed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP verified successfully (simulated).')),
        );
        context.router.replaceNamed('/change_password');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter the complete OTP.')),
        );
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
          "Verification code",
          style: TextStyle(
            color: fontcolor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                onPressed: () async {
                  // await resendOtp(context);
                  print('Resend OTP button pressed');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('OTP resent successfully (simulated).')),
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
                text: "VERIFY AND PROCEED",
                onPressed: _verifyOtp,
                // onPressed: () async {
                //   // await verifyOtp(context, _pinController.text);
                //   print('OTP verification button pressed');
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //         content:
                //             Text('OTP verified successfully (simulated).')),
                //   );
                //   context.router.replaceNamed('/change_password');
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
