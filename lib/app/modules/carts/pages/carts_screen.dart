import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/utils/app_alert_dialog.dart';
import 'package:e_commerce_app/app/config/themes/app_colors.dart';
import 'package:e_commerce_app/app/modules/activity/data/models/activity_base_models.dart';
import 'package:e_commerce_app/app/modules/activity/domain/entities/activity_base_entity.dart';
import 'package:e_commerce_app/app/modules/activity/presentation/bloc/activity_bloc.dart';
import 'package:e_commerce_app/app/modules/customers/data/models/customers_models.dart';
import 'package:e_commerce_app/app/modules/customers/presentation/bloc/customers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helpers/app_prefs.dart';
import '../../dashboard/presentation/dashboard/controllers/dashboard_controller.dart';
import '../controllers/carts_controllers.dart';
import '../widgets/carts_card_products_widget.dart';
import '../widgets/carts_header_widget.dart';
import '../widgets/carts_payment_details_bottom_sheet.dart';
import '../widgets/carts_payment_details_widget.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({
    super.key,
  });

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  var controller = Get.put(CartsController());
  final cashController = TextEditingController();
  final nameController = TextEditingController();
  DashboardController reports = Get.put(DashboardController());
  ActivityBloc activity = ActivityBloc();
  CustomersBloc customers = CustomersBloc();
  @override
  void initState() {
    activity = BlocProvider.of<ActivityBloc>(context);
    customers = BlocProvider.of<CustomersBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      margin: const EdgeInsets.only(right: 12, top: kToolbarHeight, left: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: context.screenHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.carts.length,
                  padding: const EdgeInsets.only(top: 60, bottom: 272),
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        controller.removeProduct(controller.carts[index].id!);
                        controller.updateCartCalculations();
                      },
                      background: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: double.infinity,
                              padding: const EdgeInsets.all(6),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                size: 24.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          CartsCardProductsWidget(
                            entity: controller.carts[index],
                            onTapDecrement: () {
                              controller.decreaseQuantity(
                                controller.carts[index].id!,
                              );
                              controller.updateCartCalculations();
                            },
                            onTapIncrement: () {
                              controller.increaseQuantity(
                                controller.carts[index].id!,
                              );
                              controller.updateCartCalculations();
                            },
                          ),
                          if (index != 4)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Divider(indent: 12, endIndent: 12),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const CartsHeaderWidget(),
            BlocListener<ActivityBloc, ActivityState>(
              listener: (context, state) {
                switch (state) {
                  case ActivityLoadingState():
                    context.pop();
                    context.appDialogLoading(
                      dialogContent: const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: AppColors.primary,
                      ),
                    );
                    break;
                  case ActivityPostSuccessState():
                    context.pop();
                    context.appDialogText(
                      title: 'Ordering Success',
                      message: 'See the activity menu to see ordering history',
                    );
                    break;
                  default:
                }
              },
              child: CartsPaymentWidget(
                subtotal: controller.subtotal,
                discount: controller.discount,
                tax: controller.tax,
                total: controller.total,
                onCheckout: () async {
                  if (controller.total.value != 0) {
                    cartsPaymentDetailBottomSheet(
                      context,
                      cashController: cashController,
                      nameController: nameController,
                      onChanged: (value) {
                        String sanitizedPrice = (value).replaceAll('.', '');
                        double? customerCash = double.tryParse(sanitizedPrice);

                        if (customerCash != null) {
                          reports.cartBalance.value = reports.yourBalance.value;
                          double total = controller.total.value;
                          reports.refundAmount.value;

                          debugPrint(" BALANCE ${reports.cartBalance.value}");
                          reports.refundAmount.value = customerCash - total;
                          reports.cartBalance.value =
                              reports.cartBalance.value +
                                  total -
                                  reports.refundAmount.value;

                          debugPrint("TOTAL $total");
                          debugPrint("REFUND  ${reports.refundAmount.value}");
                          debugPrint(" BALANCE ${reports.cartBalance.value}");
                        }
                      },
                      onPay: () async => await onPay(),
                      onPayLater: () async => await onPayLater(),
                    );
                  } else {
                    context.appDialogText(
                      title: 'Reminder',
                      message: 'Make sure your shopping cart is not empty',
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onPayLater() async {
    DateTime now = DateTime.now();
    String payDate = now.toLocal().toString().split(' ')[0];
    String payTime = now.toLocal().toString().split(' ')[1].substring(0, 8);

    await AppPrefReports.saveTotalOrder(1);

    customers.add(
      CustomersPostEvent(
        models: CustomersModels(
          name: nameController.text,
          lastOrder: payDate,
        ),
      ),
    );
    if (nameController.text.isNotEmpty) {
      for (var cart in controller.carts) {
        final salePriceText = cart.salePrice?.replaceAll('.', '');
        final salePrice = int.tryParse(salePriceText!);
        activity.add(
          ActivityPostEvent(
            models: ActivityModels(
              subTotal: controller.subtotal.value,
              discount: controller.discount.value,
              tax: controller.tax.value,
              total: controller.total.value,
              cash: 0,
              refundAmount: 0,
              isPay: false,
              customerName: nameController.text,
              carts: [
                CartsEntity(
                  id: cart.id,
                  name: cart.name,
                  imageUrl: cart.imageUrl,
                  quantity: cart.quantity.value,
                  salePrice: salePrice,
                )
              ],
              payDate: payDate,
              payTime: payTime,
            ),
          ),
        );
      }
      controller.carts.clear();
    }
  }

  Future<void> onPay() async {
    DateTime now = DateTime.now();
    String payDate = now.toLocal().toString().split(' ')[0];
    String payTime = now.toLocal().toString().split(' ')[1].substring(0, 8);

    if (nameController.text.isNotEmpty && cashController.text.isNotEmpty) {
      reports.yourBalance.value = reports.cartBalance.value;
      await AppPrefReports.saveEarnedToday(controller.total.value);
      await AppPrefReports.saveTotalEarned(controller.total.value);
      await AppPrefReports.saveTotalOrder(1);
      await AppPrefReports.saveYourBalance(reports.yourBalance.value);

      reports.cartBalance.value = 0.0;

      customers.add(
        CustomersPostEvent(
          models: CustomersModels(
            name: nameController.text,
            lastOrder: payDate,
          ),
        ),
      );
      final cashText = cashController.text.replaceAll('.', '');
      final cash = int.tryParse(cashText);
      for (var cart in controller.carts) {
        final salePriceText = cart.salePrice?.replaceAll('.', '');
        final salePrice = int.tryParse(salePriceText!);
        activity.add(ActivityPostEvent(
          models: ActivityModels(
            subTotal: controller.subtotal.value,
            discount: controller.discount.value,
            tax: controller.tax.value,
            total: controller.total.value,
            cash: cash,
            refundAmount: reports.refundAmount.value,
            isPay: true,
            customerName: nameController.text,
            carts: [
              CartsEntity(
                id: cart.id,
                name: cart.name,
                imageUrl: cart.imageUrl,
                quantity: cart.quantity.value,
                salePrice: salePrice,
              )
            ],
            payDate: payDate,
            payTime: payTime,
          ),
        ));
      }
      controller.carts.clear();
    }
  }
}
