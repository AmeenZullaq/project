import 'package:flutter/material.dart';

void showAlertDialog({
  required BuildContext context,
  Widget? icon,
  Widget? content,
  List<Widget>? actions,
  EdgeInsetsGeometry? iconPadding,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        actionsAlignment: MainAxisAlignment.center,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        actionsOverflowAlignment: OverflowBarAlignment.center,
        iconPadding: iconPadding ?? EdgeInsets.zero,
        // contentTextStyle: AppStyles.medium16Cabin.copyWith(
        //   color: AppColors.camarone,
        // ),
        icon: icon,
        content: content,
        actions: actions,
      );
    },
  );
}
