import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';
import 'package:paddy_rice/constants/font_size.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool obscureText;
  final FocusNode focusNode;
  final bool isError;
  final String errorMessage;
  final void Function()? onSuffixIconPressed;
  final String? Function(String?)? validator;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.obscureText = false,
    required this.focusNode,
    required this.isError,
    required this.errorMessage,
    this.onSuffixIconPressed,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: fill_color,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              prefixIcon: Icon(prefixIcon, color: iconcolor),
              suffixIcon: IconButton(
                icon: Icon(suffixIcon, color: iconcolor),
                onPressed: onSuffixIconPressed,
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: focusNode.hasFocus
                    ? focusedBorder_color
                    : isError
                        ? error_color
                        : unnecessary_colors,
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isError ? error_color : fill_color,
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
          if (isError)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                errorMessage,
                style: errorFont,
              ),
            ),
        ],
      ),
    );
  }
}
