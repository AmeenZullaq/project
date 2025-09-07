import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Pickers {
  static Future<String?> choseDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      cancelText: 'cancel',
      confirmText: 'confirm',
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      return formatDate(date);
    }
    return null;
  }

  static Future<File?> pickImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  static Future<File?> pickFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      return File(pickedFile.files.single.path!);
    }
    return null;
  }

  static String formatDate(DateTime date) {
    if (date.month < 10) {
      if (date.day < 10) {
        return '${date.year}-0${date.month}-0${date.day}';
      }
      return '${date.year}-0${date.month}-${date.day}';
    }
    if (date.day < 10) {
      if (date.month < 10) {
        return '${date.year}-0${date.month}-0${date.day}';
      }
      return '${date.year}-${date.month}-0${date.day}';
    }
    return '${date.year}-${date.month}-${date.day}';
  }
}
