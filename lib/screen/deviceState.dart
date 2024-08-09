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
      });
      Navigator.pop(context, widget.device);
    }
  }

  void incrementFrontTemp() {
    setState(() {
      frontTemp += 1;
      _isTempChanged = true;
      _frontTempController.text = frontTemp.toString();
      _updateButtonState();
    });
  }

  void decrementFrontTemp() {
    setState(() {
      frontTemp -= 1;
      _isTempChanged = true;
      _frontTempController.text = frontTemp.toString();
      _updateButtonState();
    });
  }

  void incrementBackTemp() {
    setState(() {
      backTemp += 1;
      _isTempChanged = true;
      _backTempController.text = backTemp.toString();
      _updateButtonState();
    });
  }

  void decrementBackTemp() {
    setState(() {
      backTemp -= 1;
      _isTempChanged = true;
      _backTempController.text = backTemp.toString();
      _updateButtonState();
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
          DecoratedImage(),
          Center(
            child: Padding(
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
                      const SizedBox(height: 20),
                      TemperatureInput(
                        controller: _frontTempController,
                        labelText: S.of(context)!.front_temperature,
                        isError: _isFrontTempError,
                        errorMessage: S.of(context)!.field_required,
                        onIncrement: incrementFrontTemp,
                        onDecrement: decrementFrontTemp,
                        onChanged: (value) {
                          setState(() {
                            try {
                              frontTemp = double.parse(value);
                              _isFrontTempError = false;
                            } catch (e) {
                              _isFrontTempError = true;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TemperatureInput(
                        controller: _backTempController,
                        labelText: S.of(context)!.back_temperature,
                        isError: _isBackTempError,
                        errorMessage: S.of(context)!.field_required,
                        onIncrement: incrementBackTemp,
                        onDecrement: decrementBackTemp,
                        onChanged: (value) {
                          setState(() {
                            try {
                              backTemp = double.parse(value);
                              _isBackTempError = false;
                            } catch (e) {
                              _isBackTempError = true;
                            }
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
          ),
        ],
      ),
    );
  }
}

class TemperatureInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isError;
  final String errorMessage;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ValueChanged<String>? onChanged;

  TemperatureInput({
    required this.controller,
    required this.labelText,
    required this.isError,
    required this.errorMessage,
    required this.onIncrement,
    required this.onDecrement,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312,
      height: 48,
      decoration: BoxDecoration(
          color: fill_color,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              labelText,
              style: TextStyle(
                fontSize: 16,
                color: fontcolor,
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.remove, color: Color.fromRGBO(237, 76, 47, 1)),
            onPressed: onDecrement,
          ),
          Container(
            width: 50,
            height: 48,
            alignment: Alignment.center,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(color: fontcolor),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              onChanged: onChanged,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: Color(0xFF80C080)),
            onPressed: onIncrement,
          ),
        ],
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
