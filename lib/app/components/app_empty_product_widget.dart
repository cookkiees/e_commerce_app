import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

class AppEmptyProductWidget extends StatelessWidget {
  const AppEmptyProductWidget(
      {super.key, required this.index, this.inCategoryEmpty = false});

  final int index;
  final bool inCategoryEmpty;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              setCategoryIcon(index),
              size: 24.0,
              color: Colors.grey,
            ),
            8.height,
            if (!inCategoryEmpty)
              "your product is not yet available, tap the plus button below to create a new product !"
                  .asSubtitleNormal(
                color: Colors.grey,
                textAlign: TextAlign.center,
              )
            else
              "You don't have products in this category !".asSubtitleNormal(
                color: Colors.grey,
                textAlign: TextAlign.center,
              )
          ],
        ),
      ),
    );
  }

  IconData setCategoryIcon(int index) {
    switch (index) {
      case 0:
        return Icons.rice_bowl_outlined;
      case 1:
        return Icons.local_cafe_outlined;
      case 2:
        return Icons.bubble_chart_outlined;
      case 3:
        return Icons.icecream_outlined;
      default:
        return Icons.person_outline;
    }
  }
}
