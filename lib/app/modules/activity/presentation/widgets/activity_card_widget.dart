import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/extensions/app_carrency_extension.dart';
import '../../../../common/extensions/app_datetime_extension.dart';
import '../../../../components/app_elevated_button_widget.dart';
import '../../../../components/app_text_form_field_widget.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../dashboard/presentation/dashboard/controllers/dashboard_controller.dart';
import '../../domain/entities/activity_base_entity.dart';

class ActivityCardWidget extends StatelessWidget {
  const ActivityCardWidget({
    super.key,
    this.onDetails,
    this.isDetails = false,
    this.entity,
    this.cashController,
    this.onPay,
    this.onChanged,
  });
  final void Function()? onDetails;
  final void Function()? onPay;
  final void Function(String)? onChanged;
  final bool isDetails;
  final ActivityEntity? entity;
  final TextEditingController? cashController;

  @override
  Widget build(BuildContext context) {
    DashboardController reports = Get.put(DashboardController());

    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: AppColors.primary),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: entity?.isPay ?? true
                      ? 'COMPLETED'.asSubtitleSmall(
                          color: AppColors.primary,
                        )
                      : 'PENDING'.asSubtitleSmall(
                          color: AppColors.primary,
                        )),
              4.width,
              const Icon(
                Icons.keyboard_double_arrow_right,
                size: 16,
                color: Colors.green,
              ),
              4.width,
              '${entity?.carts?.length} Items'.asSubtitleSmall(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              const Spacer(),
              if (!isDetails)
                InkWell(
                  onTap: onDetails,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Icon(
                      Icons.description_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (entity?.isPay ?? true) 12.width,
              if (entity?.isPay ?? true)
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Icon(
                    Icons.check_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                )
            ],
          ),
          12.height,
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 16.0,
                color: AppColors.primary,
              ),
              8.width,
              '${entity?.customerName}'.asSubtitleNormal(),
              const Spacer(),
              formatDate(entity?.payDate)
                  .asSubtitleSmall(color: AppColors.primary),
              ' ~ '.asSubtitleSmall(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
              '${entity?.payTime?.substring(0, 5)} WIB'
                  .asSubtitleSmall(color: AppColors.primary)
            ],
          ),
          if (isDetails) const Divider(),
          if (isDetails)
            ...List.generate(entity?.carts?.length ?? 0, (index) {
              var cart = entity?.carts?[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    '${cart?.name}'.asSubtitleNormal(),
                    12.width,
                    'x ${cart?.quantity}'.asSubtitleNormal(
                      color: Colors.grey,
                    ),
                    const Spacer(),
                    formatAsCurrency(cart?.salePrice?.toDouble() ?? 0.0)
                        .asSubtitleNormal(color: AppColors.primary),
                  ],
                ),
              );
            }),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Total Price'.asSubtitleNormal(),
              12.width,
              formatAsCurrency(entity?.total?.toDouble())
                  .asSubtitleNormal(color: AppColors.primary),
            ],
          ),
          8.height,
          if (isDetails)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: 'Cash'.asSubtitleNormal(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 44,
                    child: AppTextFormFieldWidget(
                      maxLines: 1,
                      hintText: 'Cutomer cash',
                      controller: cashController,
                      inputFormatters: [CurrencyInputFormatter()],
                      onChanged: onChanged,
                    ),
                  ),
                )
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Cash'.asSubtitleNormal(),
                12.width,
                entity?.isPay ?? true
                    ? formatAsCurrency(entity?.cash?.toDouble())
                        .asSubtitleNormal(color: AppColors.primary)
                    : '-'.asSubtitleNormal(color: AppColors.primary)
              ],
            ),
          const Divider(),
          if (isDetails)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Refund Amount'.asSubtitleNormal(),
                12.width,
                Obx(
                  () => formatAsCurrency(reports.refundAmount.value)
                      .asSubtitleNormal(color: AppColors.primary),
                )
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Refund Amount'.asSubtitleNormal(),
                12.width,
                entity?.isPay ?? true
                    ? formatAsCurrency(entity?.refundAmount?.toDouble())
                        .asSubtitleNormal(color: AppColors.primary)
                    : '-'.asSubtitleNormal(color: AppColors.primary)
              ],
            ),
          if (isDetails) 24.height,
          if (entity?.isPay == false && isDetails == true)
            SizedBox(
              height: 40,
              width: double.infinity,
              child: AppElevatedButtonWidget(
                onPressed: onPay,
                child: const Text(
                  'PAY',
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (isDetails) 40.height,
        ],
      ),
    );
  }
}
