import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:dropdown_below/dropdown_below.dart';

// import 'package:flutter_launcher_icons/main.dart';
// import 'package:paddy_rice/l10n/locali18n.dart';
// import 'package:pull_down_button/pull_down_button.dart';

const List<String> ForGot = <String>['Phone number', 'Email'];

@RoutePage()
class ForgotRoute extends StatelessWidget {
  const ForgotRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 233, 207, 1),
        leading: (IconButton(
            onPressed: () {
              context.router.replaceNamed('/login');
            },
            icon: Icon(Icons.arrow_back))),
        title: Text(
          "Reset password",
          style: TextStyle(
              color: Color.fromRGBO(77, 22, 0, 1),
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 233, 207, 1),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Container(
            // width: 312,
            // height: 48,
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(5),
            //     border: Border.all(color: Color.fromRGBO(77, 22, 0, 1))),
            child: DropdownMenuExample(),
          ),
          SizedBox(
            height: 16,
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
                  Color.fromRGBO(255, 222, 47, 1),
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
                    color: Color.fromRGBO(77, 22, 0, 1),
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

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = ForGot.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312,
      height: 48,
      child: DropdownMenu<String>(
        initialSelection: ForGot.first,
        onSelected: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            ForGot.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
