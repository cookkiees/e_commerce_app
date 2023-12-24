import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/extensions/app_carrency_extension.dart';
import '../../../components/app_elevated_button_widget.dart';
import '../../../components/app_text_form_field_widget.dart';
import '../../../config/themes/app_colors.dart';
import '../../dashboard/presentation/dashboard/controllers/dashboard_controller.dart';
import '../controllers/carts_controllers.dart';

Future<dynamic> cartsPaymentDetailBottomSheet(BuildContext context,
    {void Function()? onPay,
    void Function()? onPayLater,
    void Function(String)? onChanged,
    TextEditingController? cashController,
    TextEditingController? nameController}) {
  var controller = Get.put(CartsController());
  var reports = Get.put(DashboardController());

  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    backgroundColor: Colors.white,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        margin: context.viewInsetsBottom > 0
            ? EdgeInsets.only(bottom: context.viewInsetsBottom)
            : const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'PAYMENT DETAILS'.asSubtitleBig(
                    letterSpacing: 2,
                  ),
                  InkWell(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.clear,
                      size: 20.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              12.height,
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'YOUR BALANCE'.asSubtitleNormal(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  Obx(
                    () => formatAsCurrency(reports.yourBalance.value)
                        .asSubtitleNormal(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  )
                ],
              ),
              24.height,
              'Customer\'s Name'.asSubtitleNormal(),
              4.height,
              SizedBox(
                height: 44,
                child: AppTextFormFieldWidget(
                  controller: nameController,
                  hintText: 'Enter your customer\'s name',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-z]')),
                  ],
                ),
              ),
              12.height,
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Sub Total'.asSubtitleNormal(
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(
                        () => formatAsCurrency(controller.subtotal.value)
                            .asSubtitleNormal(
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
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(
                        () => formatAsCurrency(controller.discount.value)
                            .asSubtitleNormal(
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
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(
                        () => formatAsCurrency(controller.tax.value)
                            .asSubtitleNormal(
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
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(
                        () => formatAsCurrency(controller.total.value)
                            .asSubtitleNormal(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                  12.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: 'Cash'.asSubtitleNormal(
                          fontWeight: FontWeight.w400,
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
                  ),
                  4.height,
                  const Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Refund Amount'.asSubtitleNormal(
                        fontWeight: FontWeight.w400,
                      ),
                      Obx(
                        () => formatAsCurrency(reports.refundAmount.value)
                            .asSubtitleNormal(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                  24.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          child: AppElevatedButtonWidget(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            onPressed: onPayLater,
                            child: const Text(
                              'PAY LATER',
                              style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      24.width,
                      Flexible(
                        child: SizedBox(
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
                      ),
                    ],
                  ),
                  12.height,
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
