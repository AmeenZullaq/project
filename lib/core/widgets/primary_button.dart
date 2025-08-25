import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.elevation,
    this.fontSize,
    this.fontWeight,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? elevation;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final elevatedButtonTheme = theme.elevatedButtonTheme.style;
    
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48.h,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: elevatedButtonTheme?.copyWith(
          backgroundColor: backgroundColor != null 
              ? WidgetStateProperty.all(backgroundColor)
              : null,
          foregroundColor: textColor != null 
              ? WidgetStateProperty.all(textColor)
              : null,
          elevation: elevation != null 
              ? WidgetStateProperty.all(elevation)
              : null,
          shape: borderRadius != null 
              ? WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                )
              : null,
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? theme.colorScheme.onPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    text,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
