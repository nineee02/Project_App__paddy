import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

@RoutePage()
class EditProfileRoute extends StatelessWidget {
  const EditProfileRoute({super.key});

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
        child: Column(
          children: [
            // TextField(
            //   decoration: InputDecoration(
            //       labelText: "Email address", suffixIcon: Icon(Icons.email)),
            // ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Edward Lorry",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Senior Designer",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
