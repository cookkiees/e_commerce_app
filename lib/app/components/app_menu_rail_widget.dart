import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../config/themes/app_colors.dart';

class AppMenuRailWidget extends StatelessWidget {
  const AppMenuRailWidget({
    super.key,
    this.label = 'label',
    this.isSelected = false,
    this.icon,
  });
  final IconData? icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
              ),
              12.width,
              if (isSelected)
                Shimmer.fromColors(
                    baseColor: AppColors.primary,
                    highlightColor: AppColors.primary.withOpacity(0.1),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          size: 14,
                        ),
                        8.width,
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ))
              else
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        ),
        if (isSelected)
          FadeIn(
            child: Container(
              height: 30,
              width: double.infinity,
              color: AppColors.primary.withOpacity(0.1),
            ),
          )
      ],
    );
  }
}
