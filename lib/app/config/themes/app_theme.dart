import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_page_transitions_theme.dart';

mixin class AppTheme {
  static ThemeData defaults() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      pageTransitionsTheme: getPageTransitionsTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          surfaceTintColor: AppColors.primary,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      tabBarTheme: const TabBarTheme(),
      cardTheme: const CardTheme(),
      chipTheme: const ChipThemeData(),
      iconTheme: const IconThemeData(),
      menuTheme: const MenuThemeData(),
      badgeTheme: const BadgeThemeData(),
      radioTheme: const RadioThemeData(),
      textTheme: const TextTheme(),
      bannerTheme: const MaterialBannerThemeData(),
      buttonTheme: const ButtonThemeData(),
      dialogTheme: const DialogTheme(),
      drawerTheme: const DrawerThemeData(),
      sliderTheme: const SliderThemeData(),
      switchTheme: const SwitchThemeData(),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dividerTheme: const DividerThemeData(),
      menuBarTheme: const MenuBarThemeData(),
      checkboxTheme: const CheckboxThemeData(),
      listTileTheme: const ListTileThemeData(),
      snackBarTheme: const SnackBarThemeData(),
      tooltipTheme: const TooltipThemeData(),
      buttonBarTheme: const ButtonBarThemeData(),
      popupMenuTheme: const PopupMenuThemeData(),
      iconButtonTheme: const IconButtonThemeData(),
      actionIconTheme: const ActionIconThemeData(),
      scrollbarTheme: const ScrollbarThemeData(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(),
      dataTableTheme: const DataTableThemeData(),
      textButtonTheme: const TextButtonThemeData(),
      dropdownMenuTheme: const DropdownMenuThemeData(),
    );
  }
}
