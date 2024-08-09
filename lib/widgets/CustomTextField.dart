import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

/// The line `import 'package:paddy_rice/constants/font_size.dart';` is importing a Dart file named
/// `font_size.dart` from the `constants` directory within the `paddy_rice` package. This file likely
/// contains predefined font sizes that are used within the `CustomTextField` widget or other parts of
/// the application. By importing this file, the widget can access and use the font sizes defined in
/// `font_size.dart` to maintain consistency in the styling of text elements throughout the application.
import 'package:paddy_rice/constants/font_size.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool obscureText;
  final bool isError;
  final String errorMessage;
  final void Function()? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged; // Add this line

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.obscureText = false,
    required this.isError,
    required this.errorMessage,
    this.onSuffixIconPressed,
    this.validator,
    this.onChanged, // Add this line
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
    });
    if (widget.onChanged != null) {
      widget.onChanged!(widget.controller.text);
    }
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
            decoration: InputDecoration(
              filled: true,
              fillColor: fill_color,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              prefixIcon: Icon(widget.prefixIcon, color: iconcolor),
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
                        : unnecessary_colors,
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
              padding: const EdgeInsets.only(top: 4.0, left: 16.0),
              child: Text(
                widget.errorMessage,
                style: errorFont,
              ),
            ),
        ],
      ),
    );
  }
}
