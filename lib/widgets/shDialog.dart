import 'package:flutter/material.dart';
import 'package:paddy_rice/constants/color.dart';

class ShDialog extends StatelessWidget {
  final String title;
  final String content;
  final BuildContext parentContext;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  ShDialog({
    required this.title,
    required this.content,
    required this.parentContext,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      backgroundColor: maincolor,
      title: Text(
        title,
        style: TextStyle(
            color: fontcolor, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: Text(
        content,
        style: TextStyle(
            color: fontcolor, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            cancelButtonText,
            style: TextStyle(color: fontcolor, fontWeight: FontWeight.w500),
          ),
          onPressed: onCancel,
        ),
        TextButton(
          child: Text(
            confirmButtonText,
            style: TextStyle(color: fontcolor, fontWeight: FontWeight.w600),
          ),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
