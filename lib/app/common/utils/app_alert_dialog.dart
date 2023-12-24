import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/themes/app_colors.dart';

extension ShowDialogExtension on BuildContext {
  void appAlertReportsDialog(
      {void Function()? onReset, String? title, String? content}) {
    showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actionsPadding:
              const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          titlePadding: const EdgeInsets.only(left: 12, right: 12, top: 12),
          contentPadding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          title: '$title'.asSubtitleBig(
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
          content: '$content'.asSubtitleNormal(
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          actions: [
            InkWell(
              onTap: () => context.pop(),
              child: 'No'.asSubtitleNormal(
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ),
            24.width,
            InkWell(
              onTap: onReset,
              child: 'Sure'.asSubtitleNormal(
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ),
          ],
        );
      },
    );
  }

  void appDialogLoading({required Widget dialogContent}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth / 3.5),
          child: AlertDialog(
            alignment: Alignment.center,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            content: dialogContent,
          ),
        );
      },
    );
  }

  void appDialogText({required String message, String? title}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          contentPadding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          title: Text(
            '$title',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
