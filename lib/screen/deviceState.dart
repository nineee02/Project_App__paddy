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

  @override
  void initState() {
    super.initState();
    deviceName = widget.device.name;
    frontTemp = widget.device.frontTemp;
    backTemp = widget.device.backTemp;
    humidity = widget.device.humidity; // Initialize humidity

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

  void _handleUpdateSettings() {
    if (_isButtonEnabled) {
      updateDeviceSettings();
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
          '${S.of(context)!.device_settings(widget.device.name)}',
          style: appBarFont,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // DecoratedImage(),
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
                            TemperatureInput(
                              tempType: selectedTempType,
                              currentTemp: selectedTempType == 'Front'
                                  ? frontTemp
                                  : selectedTempType == 'Back'
                                      ? backTemp
                                      : humidity,
                              onIncrement: incrementTemp,
                              onDecrement: decrementTemp,
                              onSelectType: selectTempType,
                            ),
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
                            InfoRow(
                              label: 'Front Temp',
                              currentValue: 46,
                              maxValue: frontTemp,
                              unit: '°C',
                              onTap: () {
                                setState(() {
                                  selectedTempType = 'Front';
                                });
                              },
                            ),
                            InfoRow(
                              label: 'Back Temp',
                              currentValue: 32,
                              maxValue: backTemp,
                              unit: '°C',
                              onTap: () {
                                setState(() {
                                  selectedTempType = 'Back';
                                });
                              },
                            ),
                            InfoRow(
                              label: 'Humidity',
                              currentValue: 21,
                              maxValue: humidity,
                              unit: '%',
                              onTap: () {
                                setState(() {
                                  selectedTempType = 'Humidity';
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: S.of(context)!.update_settings,
                              onPressed: _handleUpdateSettings,
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
    );
  }
}

class TemperatureInput extends StatefulWidget {
  final String tempType;
  final double currentTemp;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final void Function(String) onSelectType;

  TemperatureInput({
    required this.tempType,
    required this.currentTemp,
    required this.onIncrement,
    required this.onDecrement,
    required this.onSelectType,
  });

  @override
  _TemperatureInputState createState() => _TemperatureInputState();
}

class _TemperatureInputState extends State<TemperatureInput> {
  Timer? _timer;

  void _startTimer(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      action();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.tempType,
            style: TextStyle(
              fontSize: 14,
              color: unnecessary_colors,
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onLongPressStart: (_) => _startTimer(widget.onDecrement),
              onLongPressEnd: (_) => _stopTimer(),
              onTap: widget.onDecrement,
              child: Icon(Icons.remove, color: Color.fromRGBO(237, 76, 47, 1)),
            ),
            SizedBox(width: 16),
            Text(
              '${widget.currentTemp}',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: fontcolor,
              ),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onLongPressStart: (_) => _startTimer(widget.onIncrement),
              onLongPressEnd: (_) => _stopTimer(),
              onTap: widget.onIncrement,
              child: Icon(Icons.add, color: Color(0xFF80C080)),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          widget.tempType,
          style: TextStyle(
            fontSize: 18,
            color: unnecessary_colors,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor:
                  widget.tempType == 'Front' ? Colors.green : Colors.grey,
              child: GestureDetector(
                onTap: () => widget.onSelectType('Front'),
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              radius: 10,
              backgroundColor:
                  widget.tempType == 'Back' ? Colors.green : Colors.grey,
              child: GestureDetector(
                onTap: () => widget.onSelectType('Back'),
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              radius: 10,
              backgroundColor:
                  widget.tempType == 'Humidity' ? Colors.green : Colors.grey,
              child: GestureDetector(
                onTap: () => widget.onSelectType('Humidity'),
              ),
            ),
          ],
        ),
      ],
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
          width: 312,
          height: 48,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.grey[700],
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      color: fontcolor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$currentValue',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: fontcolor,
                    ),
                  ),
                  Text(
                    ' / $maxValue',
                    style: TextStyle(
                      fontSize: 16,
                      color: fontcolor,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    unit,
                    style: TextStyle(
                      fontSize: 16,
                      color: fontcolor,
                    ),
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
