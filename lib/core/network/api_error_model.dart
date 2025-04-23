import 'package:flutter/material.dart';

class ApiErrorModel {
  final String errorMessage;
  final Widget? errorImage;
  final int? statusCode;

  const ApiErrorModel({
    required this.errorMessage,
    this.errorImage,
    this.statusCode,
  });
}
