import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

@RoutePage()
class OtpRoute extends StatelessWidget {
  const OtpRoute({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _pinController = TextEditingController();

    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconcolor),
          onPressed: () => context.router.replaceNamed('/forgot'),
        ),
        title: Text(
          "OTP Verification",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.email, size: 100, color: iconcolor), // Email icon
            SizedBox(height: 20),
            Text(
              "Please enter the 4 digit verification code sent to +90 536 585 86 16",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: fontcolor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 4,
              controller: _pinController,
              pinTheme: PinTheme(
                activeColor: Colors.white,
                selectedColor: iconcolor,
                inactiveColor: Colors.grey,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Implement resend OTP logic here
              },
              child: Text(
                "Didn't receive the OTP? Resend code",
                style: TextStyle(color: fontcolor),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttoncolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                minimumSize: Size(312, 48),
              ),
              onPressed: () {
                // Add verify OTP logic here
                print("OTP Entered: ${_pinController.text}");
                context.router.replaceNamed('/login');
              },
              child: Text(
                "VERIFY AND PROCEED",
                style: TextStyle(
                    color: fontcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
