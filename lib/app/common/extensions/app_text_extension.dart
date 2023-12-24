import 'package:e_commerce_app/app/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension AppTextExtensions on String {
  Widget asLabelButton({Color? color}) => Text(
        this,
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.w400,
        ),
      );
  Widget asTitleBig({Color? color, FontWeight? fontWeight}) => Text(
        this,
        style: TextStyle(
          fontSize: 24,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      );

  Widget asTitleNormal({Color? color, FontWeight? fontWeight}) => Text(
        this,
        style: TextStyle(
          fontSize: 18,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w300,
        ),
      );

  Widget asTitleSmall({Color? color, FontWeight? fontWeight}) => Text(
        this,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w300,
        ),
      );

  Widget asSubtitleBig(
          {int? maxLines,
          Color? color,
          FontWeight? fontWeight,
          double? letterSpacing,
          TextOverflow? overflow}) =>
      Text(
        this,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 14,
          color: color,
          letterSpacing: letterSpacing,
          fontWeight: fontWeight ?? FontWeight.w300,
          overflow: overflow,
        ),
      );

  Widget asSubtitleNormal(
          {Color? color,
          TextOverflow? overflow,
          FontWeight? fontWeight,
          TextAlign? textAlign,
          double? letterSpacing,
          int? maxLines}) =>
      Text(
        this,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 12,
          color: color,
          letterSpacing: letterSpacing,
          fontWeight: fontWeight ?? FontWeight.w300,
          overflow: overflow,
        ),
      );

  Widget asSubtitleSmall(
          {TextAlign? textAlign,
          Color? color,
          int? maxLines,
          FontWeight? fontWeight,
          TextDecoration? decoration,
          TextOverflow? overflow}) =>
      Text(
        this,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w300,
          overflow: overflow,
          decorationColor: AppColors.primary,
          decoration: decoration,
        ),
      );
}
