import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:icapps_torch_compat/icapps_torch_compat.dart';

@RoutePage()
class ScanRoute extends StatefulWidget {
  const ScanRoute({Key? key}) : super(key: key);

  @override
  _ScanRouteState createState() => _ScanRouteState();
}

class _ScanRouteState extends State<ScanRoute> {
  bool _torchIsOn = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
    // Optionally start the camera here if needed
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

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
      body: Stack(
        children: [
          Container(
            color: maincolor, // Change this color to match your background
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () => context.router.replaceNamed('/home'),
                icon: Icon(Icons.arrow_back, color: iconcolor),
              ),
              title: Text(
                "Scan",
                style: TextStyle(
                    color: fontcolor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
