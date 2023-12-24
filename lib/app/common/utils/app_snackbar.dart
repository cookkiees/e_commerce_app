import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

extension ShowSnackbarExtension on BuildContext {
  void appSnackbar({required Widget content}) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.vertical,
        behavior: SnackBarBehavior.fixed,
        elevation: 0.5,
        showCloseIcon: true,
        backgroundColor: AppColors.primary,
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        content: content,
      ),
    );
  }
}
