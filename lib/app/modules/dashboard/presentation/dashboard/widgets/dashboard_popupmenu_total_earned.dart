import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../config/themes/app_colors.dart';

enum PopupMenuActionTotalEarned { reset }

extension EarnedTodayExtension on PopupMenuActionTotalEarned {
  String get name {
    switch (this) {
      case PopupMenuActionTotalEarned.reset:
        return 'Reset';
      default:
        return '';
    }
  }
}

class PopupMenuTotalEarnedWidget extends StatelessWidget {
  const PopupMenuTotalEarnedWidget({super.key, this.onSelected});
  final void Function(PopupMenuActionTotalEarned)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuActionTotalEarned>(
      onSelected: onSelected,
      surfaceTintColor: Colors.white,
      position: PopupMenuPosition.under,
      padding: EdgeInsets.zero,
      color: Colors.white,
      iconSize: 16,
      icon: const Icon(Icons.more_vert, color: AppColors.primary),
      itemBuilder: (BuildContext context) {
        return PopupMenuActionTotalEarned.values.map((e) {
          return PopupMenuItem<PopupMenuActionTotalEarned>(
            value: e,
            child: e.name.asSubtitleNormal(),
          );
        }).toList();
      },
    );
  }
}
