import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../config/themes/app_colors.dart';

enum PopupMenuActionTotalOrders { reset }

extension EarnedTodayExtension on PopupMenuActionTotalOrders {
  String get name {
    switch (this) {
      case PopupMenuActionTotalOrders.reset:
        return 'Reset';
      default:
        return '';
    }
  }
}

class PopupMenuTotalOrdersWidget extends StatelessWidget {
  const PopupMenuTotalOrdersWidget({super.key, this.onSelected});
  final void Function(PopupMenuActionTotalOrders)? onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuActionTotalOrders>(
      onSelected: onSelected,
      surfaceTintColor: Colors.white,
      position: PopupMenuPosition.under,
      padding: EdgeInsets.zero,
      color: Colors.white,
      iconSize: 16,
      icon: const Icon(Icons.more_vert, color: AppColors.primary),
      itemBuilder: (BuildContext context) {
        return PopupMenuActionTotalOrders.values.map((e) {
          return PopupMenuItem<PopupMenuActionTotalOrders>(
            value: e,
            child: e.name.asSubtitleNormal(),
          );
        }).toList();
      },
    );
  }
}
