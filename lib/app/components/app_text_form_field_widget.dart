import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/themes/app_colors.dart';

class AppTextFormFieldWidget extends StatelessWidget {
  const AppTextFormFieldWidget({
    super.key,
    this.obscureText = false,
    this.onTap,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.readOnly = false,
    this.error,
    this.style,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.helperMaxLines,
    this.expands = false,
    this.helperText,
  });
  final Widget? error;
  final bool expands;
  final int? maxLines;
  final int? maxLength;
  final int? helperMaxLines;
  final bool readOnly;
  final bool obscureText;
  final String? helperText;
  final String? hintText;
  final String? errorText;
  final TextStyle? style;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: expands,
      obscureText: obscureText,
      onTap: onTap,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      cursorColor: AppColors.primary,
      cursorWidth: 1,
      maxLines: maxLines,
      style: style ??
          const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        helperText: helperText,
        helperMaxLines: helperMaxLines,
        helperStyle: const TextStyle(color: Colors.grey, fontSize: 10),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        error: error,
        constraints: const BoxConstraints(minHeight: 44),
        hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        errorText: errorText,
        contentPadding: contentPadding ??
            const EdgeInsets.only(left: 12, bottom: 0.5, right: 12),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
