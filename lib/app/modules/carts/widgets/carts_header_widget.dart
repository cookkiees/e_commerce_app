import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';

class CartsHeaderWidget extends StatelessWidget {
  const CartsHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 48,
        color: AppColors.primary,
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            'CARTS'.asSubtitleBig(
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
