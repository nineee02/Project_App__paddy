import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';
import 'package:paddy_rice/widgets/CustomButton.dart';
import 'package:paddy_rice/widgets/decorated_image.dart';
import 'package:paddy_rice/widgets/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeviceSateRoute extends StatefulWidget {
  final Device device;

  DeviceSateRoute({required this.device});

  @override
  _DeviceSateRouteState createState() => _DeviceSateRouteState();
}

class _DeviceSateRouteState extends State<DeviceSateRoute> {
  late String deviceName;
  late double frontTemp;
  late double backTemp;
  late double humidity;
  String selectedTempType = 'Front';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _deviceNameController = TextEditingController();
  final TextEditingController _frontTempController = TextEditingController();
  final TextEditingController _backTempController = TextEditingController();

  bool _isDeviceNameError = false;
  bool _isFrontTempError = false;
  bool _isBackTempError = false;
  bool _isTempChanged = false;
  bool _isButtonEnabled = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    deviceName = widget.device.name;
    frontTemp = widget.device.frontTemp;
    backTemp = widget.device.backTemp;
    humidity = widget.device.humidity;

    _deviceNameController.text = deviceName;
    _frontTempController.text = frontTemp.toString();
    _backTempController.text = backTemp.toString();

    _deviceNameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = (_deviceNameController.text.isNotEmpty &&
              _deviceNameController.text != widget.device.name) ||
          _isTempChanged;
    });
  }

  Future<void> _handleUpdateSettings() async {
    if (_isButtonEnabled) {
      setState(() {
        isLoading = true; // เริ่มสถานะการโหลด
      });

      await Future.delayed(
          Duration(seconds: 2)); // จำลองการบันทึกการเปลี่ยนแปลง

      updateDeviceSettings();

      setState(() {
        isLoading = false; // ยกเลิกสถานะการโหลดเมื่อเสร็จสิ้น
      });
    }
  }

  void updateDeviceSettings() {
    if (deviceName.isEmpty) {
      setState(() {
        _isDeviceNameError = true;
      });
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        widget.device.name = deviceName;
        widget.device.frontTemp = frontTemp;
        widget.device.backTemp = backTemp;
        widget.device.humidity = humidity;
      });
      Navigator.pop(context, widget.device);
    }
  }

  void incrementTemp() {
    setState(() {
      if (selectedTempType == 'Front') {
        frontTemp += 1;
        _frontTempController.text = frontTemp.toString();
      } else if (selectedTempType == 'Back') {
        backTemp += 1;
        _backTempController.text = backTemp.toString();
      } else if (selectedTempType == 'Humidity') {
        humidity += 1;
      }
      _isTempChanged = true;
      _updateButtonState();
    });
  }

  void decrementTemp() {
    setState(() {
      if (selectedTempType == 'Front') {
        frontTemp -= 1;
        _frontTempController.text = frontTemp.toString();
      } else if (selectedTempType == 'Back') {
        backTemp -= 1;
        _backTempController.text = backTemp.toString();
      } else if (selectedTempType == 'Humidity') {
        humidity -= 1;
      }
      _isTempChanged = true;
      _updateButtonState();
    });
  }

  void selectTempType(String type) {
    setState(() {
      selectedTempType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text(
          S.of(context)!.device_settings(widget.device.name),
          style: appBarFont,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          DecoratedImage(),
          Column(
            children: [
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: fontcolor,
                            fontSize: 16,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                TextFieldCustom(
                                  controller: _deviceNameController,
                                  labelText: S.of(context)!.device_name,
                                  suffixIcon: Icons.clear,
                                  isError: _isDeviceNameError,
                                  errorMessage: S.of(context)!.field_required,
                                  onSuffixIconPressed: () {
                                    _deviceNameController.clear();
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      deviceName = value;
                                      _isDeviceNameError = value.isEmpty;
                                      _updateButtonState();
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16)),
                                    InfoRow(
                                      label: S.of(context)!.front_temperature,
                                      currentValue: 46,
                                      maxValue: frontTemp,
                                      unit: '°C',
                                      onTap: () {
                                        setState(() {
                                          selectedTempType = 'Front';
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    InfoRow(
                                      label: S.of(context)!.back_temperature,
                                      currentValue: 32,
                                      maxValue: backTemp,
                                      unit: '°C',
                                      onTap: () {
                                        setState(() {
                                          selectedTempType = 'Back';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16)),
                                    InfoRow(
                                      label: S.of(context)!.humidity_,
                                      currentValue: 21,
                                      maxValue: humidity,
                                      unit: '%',
                                      onTap: () {
                                        setState(() {
                                          selectedTempType = 'Humidity';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                CustomButton(
                                  text: S.of(context)!.save,
                                  onPressed: () async {
                                    await _handleUpdateSettings();
                                  },
                                  isLoading: isLoading,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final double currentValue;
  final double maxValue;
  final String unit;
  final VoidCallback onTap;

  InfoRow({
    required this.label,
    required this.currentValue,
    required this.maxValue,
    required this.unit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (label.contains('Humidity')) {
      icon = Icons.water_drop;
    } else {
      icon = Icons.thermostat;
    }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 148,
          height: 112,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: fill_color,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      color: fontcolor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Current : ',
                        style: TextStyle(
                          fontSize: 14,
                          color: unnecessary_colors,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Target : ',
                        style: TextStyle(
                          fontSize: 14,
                          color: unnecessary_colors,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$currentValue',
                            style: TextStyle(
                              fontSize: 16,
                              color: fontcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            unit,
                            style: TextStyle(
                              fontSize: 16,
                              color: fontcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '$maxValue',
                            style: TextStyle(
                              fontSize: 16,
                              color: fontcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            unit,
                            style: TextStyle(
                              fontSize: 16,
                              color: fontcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldCustom extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData suffixIcon;
  final bool obscureText;
  final bool isError;
  final String errorMessage;
  final void Function()? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  TextFieldCustom({
    required this.controller,
    required this.labelText,
    required this.suffixIcon,
    this.obscureText = false,
    required this.isError,
    required this.errorMessage,
    this.onSuffixIconPressed,
    this.validator,
    this.onChanged,
  });

  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_handleTextChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTextChange() {
    setState(() {
      _hasText = widget.controller.text.isNotEmpty;
      widget.onChanged?.call(widget.controller.text);
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    widget.controller.removeListener(_handleTextChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            obscureText: widget.obscureText,
            validator: widget.validator,
            style: TextStyle(color: fontcolor),
            decoration: InputDecoration(
              filled: true,
              fillColor: fill_color,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              suffixIcon: (_isFocused || _hasText)
                  ? IconButton(
                      icon: Icon(widget.suffixIcon, color: iconcolor),
                      onPressed: widget.onSuffixIconPressed,
                    )
                  : null,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: _isFocused
                    ? focusedBorder_color
                    : widget.isError
                        ? error_color
                        : Colors.grey,
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.isError ? error_color : fill_color,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorder_color, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error_color, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error_color, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          if (widget.isError)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 16),
              child: Text(
                widget.errorMessage,
                style: TextStyle(
                  color: error_color,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
