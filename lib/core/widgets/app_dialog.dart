import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    this.icon,
    this.content,
    this.actions,
    this.iconPadding,
  });

  final Widget? icon;
  final Widget? content;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? iconPadding;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      actionsAlignment: MainAxisAlignment.center,
      surfaceTintColor:Colors.white,
      shadowColor:Colors.black,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      iconPadding: iconPadding ?? EdgeInsets.zero,
      // contentTextStyle: AppStyles.medium16Cabin.copyWith(
      //   color: AppColors.camarone,
      // ),
      icon: icon,
      content: content,
      actions: actions,
    );
  }
}
