import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/extensions/app_carrency_extension.dart';
import '../../../components/app_elevated_button_widget.dart';
import '../../../config/themes/app_colors.dart';

class CartsPaymentWidget extends StatelessWidget {
  const CartsPaymentWidget({
    super.key,
    this.subtotal,
    this.tax,
    this.discount,
    this.total,
    this.onCheckout,
  });
  final RxDouble? subtotal;
  final RxDouble? tax;
  final RxDouble? discount;
  final RxDouble? total;
  final void Function()? onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 80),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2, -3),
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Sub Total'.asSubtitleNormal(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                    Obx(
                      () => formatAsCurrency(subtotal!.value).asSubtitleNormal(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                8.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Discount'.asSubtitleNormal(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                    Obx(
                      () => formatAsCurrency(discount!.value).asSubtitleNormal(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                8.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Tax 5%'.asSubtitleNormal(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                    Obx(
                      () => formatAsCurrency(tax!.value).asSubtitleNormal(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Total'.asSubtitleNormal(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    Obx(
                      () => formatAsCurrency(total!.value).asSubtitleNormal(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          12.height,
          SizedBox(
            height: 44,
            width: double.infinity,
            child: AppElevatedButtonWidget(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 12, right: 8),
                shape: const RoundedRectangleBorder(),
              ),
              child: Row(
                children: [
                  const Text(
                    'CHECKOUT',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: AppColors.primary,
                    child: const Icon(
                      Icons.keyboard_double_arrow_right,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
