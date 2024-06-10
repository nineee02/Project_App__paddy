import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

@RoutePage()
class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(
          "Silo",
          style: TextStyle(
            color: fontcolor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.router.replaceNamed('/notifi');
            },
            icon: Icon(
              Icons.notifications_outlined,
              size: 24,
              color: iconcolor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Icon(
                  Icons.add_circle_outline,
                  size: 24,
                  color: iconcolor,
                ),
                items: [
                  ...MenuItems.firstItems.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                  const DropdownMenuItem<Divider>(
                      enabled: false, child: Divider()),
                  ...MenuItems.secondItems.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                ],
                onChanged: (value) {
                  MenuItems.onChanged(context, value! as MenuItem);
                },
                dropdownStyleData: DropdownStyleData(
                  width: 160,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: fill_color,
                  ),
                  offset: const Offset(-144, 8),
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: [
                    ...List<double>.filled(MenuItems.firstItems.length, 48),
                    8,
                    ...List<double>.filled(MenuItems.secondItems.length, 48),
                  ],
                  padding: const EdgeInsets.only(left: 16, right: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
          ),
        ],
        selectedItemColor: iconcolor,
        unselectedItemColor: Color.fromRGBO(217, 217, 217, 1),
        onTap: (int index) {
          if (index == 0) {
            context.router.replaceNamed('/home');
          } else if (index == 1) {
            context.router.replaceNamed('/profile');
          }
        },
      ),
      backgroundColor: maincolor,
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 24),
              Container(
                width: 316,
                height: 135,
                decoration: BoxDecoration(
                  color: fill_color,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'lib/assets/icon/home.png',
                        height: 94,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Divider(
                      height: 1.0,
                      color: Color.fromRGBO(215, 215, 215, 1),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                      "No devices",
                      style: TextStyle(
                          color: Color.fromRGBO(137, 137, 137, 1),
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 316,
                height: 135,
                color: fill_color,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                  ),
                  onPressed: () {
                    context.router.replaceNamed('/device1');
                  },
                  child: Text(
                    "No devices",
                    style: TextStyle(
                        color: Color.fromRGBO(137, 137, 137, 1), fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: fontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [
    devices,
    scan_qr,
  ];
  static const List<MenuItem> secondItems = [];

  static const devices =
      MenuItem(text: 'Add devices', icon: Icons.extension_outlined);
  static const scan_qr =
      MenuItem(text: 'Scan', icon: Icons.qr_code_scanner_outlined);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Color.fromRGBO(77, 22, 0, 1), size: 24),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Color.fromRGBO(77, 22, 0, 1),
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.devices:
        context.router.replaceNamed('/addDevice');
        break;
      case MenuItems.scan_qr:
        context.router.replaceNamed('/scan');
        break;
    }
  }
}
