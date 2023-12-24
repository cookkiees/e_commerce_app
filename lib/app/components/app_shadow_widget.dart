import 'package:flutter/material.dart';

import '../config/themes/app_colors.dart';

List<BoxShadow> appShadowWidget({Color? color}) {
  return [
    BoxShadow(
      color: color ?? AppColors.primary.withOpacity(0.5),
      offset: const Offset(0, 2),
    )
  ];
}
