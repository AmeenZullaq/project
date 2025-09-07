import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showBottomSheet(
  BuildContext context, {
  required Widget widget,
}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
    ),
    isDismissible: false,
    showDragHandle: true,
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return widget;
    },
  );
}
