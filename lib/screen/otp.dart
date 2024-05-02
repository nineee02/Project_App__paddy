import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class OtpRoute extends StatelessWidget {
  const OtpRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: (IconButton(
          onPressed: () {
            context.router.replaceNamed('/forgot');
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        )),
        title: Text(
          "OTP",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Column(
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
            Container(),
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
                  context.router.replaceNamed('/login');
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
          ],
        ),
      ),
    );
  }
}
