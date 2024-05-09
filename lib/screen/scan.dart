import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:icapps_torch_compat/icapps_torch_compat.dart';

class ScanRoute extends StatefulWidget {
  const ScanRoute({Key? key}) : super(key: key);

  @override
  _ScanRouteState createState() => _ScanRouteState();
}

class _ScanRouteState extends State<ScanRoute> {
  bool _torchIsOn = false;

  // Function to handle opening the gallery
  void _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker(); // Create a new instance here
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Optionally handle the selected image file
      print('Selected image path: ${image.path}');
    }
  }

  // Function to toggle the torch
  void _toggleTorch() async {
    if (_torchIsOn) {
      await TorchCompat.turnOff();
    } else {
      await TorchCompat.turnOn();
    }
    setState(() {
      _torchIsOn = !_torchIsOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
          onPressed: () => context.router.replaceNamed('/home'),
          icon: Icon(Icons.arrow_back, color: iconcolor),
        ),
        title: Text(
          "Scan",
          style: TextStyle(
              color: fontcolor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Please scan the QR code on the device or user manual",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: fontcolor,
                      fontSize: 12,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.router.replaceNamed('/addDevice');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: fontcolor,
                    backgroundColor: buttoncolor,
                  ),
                  child: Text(
                    "No QR code available",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            left: 50,
            right: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: () => _openGallery(context),
                  child: Icon(Icons.image_search_outlined),
                  backgroundColor: buttoncolor,
                ),
                FloatingActionButton(
                  onPressed: _toggleTorch,
                  child: Icon(_torchIsOn
                      ? Icons.flashlight_off_outlined
                      : Icons.flashlight_on_outlined),
                  backgroundColor: buttoncolor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
