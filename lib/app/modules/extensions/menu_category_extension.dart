import 'package:flutter/material.dart';

enum MenuCategory {
  food,
  drinks,
  snacks,
  iceCream,
}

extension MenuCategoryExtension on MenuCategory {
  String get name {
    switch (this) {
      case MenuCategory.food:
        return 'FOOD';
      case MenuCategory.drinks:
        return 'DRINKS';
      case MenuCategory.snacks:
        return 'SNACKS';
      case MenuCategory.iceCream:
        return 'ICE CREAM';
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case MenuCategory.food:
        return Icons.rice_bowl_outlined;
      case MenuCategory.drinks:
        return Icons.local_cafe_outlined;
      case MenuCategory.snacks:
        return Icons.bubble_chart_outlined;
      case MenuCategory.iceCream:
        return Icons.icecream_outlined;

      default:
        return Icons.person_outline;
    }
  }
}
