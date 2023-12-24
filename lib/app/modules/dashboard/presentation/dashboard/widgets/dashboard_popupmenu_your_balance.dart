import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../config/themes/app_colors.dart';

enum PopupMenuActionYourBalance { withdrawal, edit, reset }

extension EarnedTodayExtension on PopupMenuActionYourBalance {
  String get name {
    switch (this) {
      case PopupMenuActionYourBalance.withdrawal:
        return 'Withdrawal';
      case PopupMenuActionYourBalance.edit:
        return 'Edit';
      case PopupMenuActionYourBalance.reset:
        return 'Reset';
      default:
        return '';
    }
  }
}

class PopupMenuYourBalanceWidget extends StatelessWidget {
  const PopupMenuYourBalanceWidget({super.key, this.onSelected});
  final void Function(PopupMenuActionYourBalance)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuActionYourBalance>(
      onSelected: onSelected,
      surfaceTintColor: Colors.white,
      position: PopupMenuPosition.under,
      padding: EdgeInsets.zero,
      color: Colors.white,
      iconSize: 16,
      icon: const Icon(Icons.more_vert, color: AppColors.primary),
      itemBuilder: (BuildContext context) {
        return PopupMenuActionYourBalance.values.map((e) {
          return PopupMenuItem<PopupMenuActionYourBalance>(
            value: e,
            child: e.name.asSubtitleNormal(),
          );
        }).toList();
      },
    );
  }
}
