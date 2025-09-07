import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String text,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
    ),
  );
}
