import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.errorText,
    this.helperText,
    this.fillColor,
    this.borderRadius,
    this.contentPadding,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final String? errorText;
  final String? helperText;
  final Color? fillColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontSize: 16.sp,
        color: enabled ? theme.colorScheme.onSurface : theme.disabledColor,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        helperText: helperText,
        filled: true,
        fillColor: fillColor,
        contentPadding: contentPadding,
        border: borderRadius != null 
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              )
            : null,
        enabledBorder: borderRadius != null 
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              )
            : null,
        focusedBorder: borderRadius != null 
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              )
            : null,
        errorBorder: borderRadius != null 
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              )
            : null,
        focusedErrorBorder: borderRadius != null 
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              )
            : null,
        disabledBorder: borderRadius != null 
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              )
            : null,
      ),
    );
  }
}
