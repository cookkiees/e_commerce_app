import 'dart:io';

import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/common/utils/app_alert_dialog.dart';
import 'package:e_commerce_app/app/components/app_elevated_button_widget.dart';
import 'package:e_commerce_app/app/modules/activity/domain/entities/activity_base_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/helpers/app_prefs.dart';
import '../../../dashboard/presentation/dashboard/controllers/dashboard_controller.dart';
import '../../../main/controllers/main_controller.dart';
import '../../data/models/activity_base_models.dart';
import '../bloc/activity_bloc.dart';
import '../extensions/acticity_extension.dart';
import '../widgets/activity_card_widget.dart';
import '../widgets/activity_shimmer_loading_widget.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  TextEditingController cashController = TextEditingController();
  DashboardController reports = Get.put(DashboardController());
  MainController main = Get.put(MainController());
  late ActivityBloc activity;

  @override
  void initState() {
    super.initState();
    activity = BlocProvider.of<ActivityBloc>(context);
    activity.add(const ActivityGetInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: false,
        title: "ACTIVITY".asSubtitleBig(fontWeight: FontWeight.w400),
      ),
      body: NestedScrollView(headerSliverBuilder: (context, _) {
        return [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 40,
            expandedHeight: 40,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(left: 14, right: 12, top: 12),
                child: Obx(
                  () {
                    var selected = main.selectedActivity.value;
                    return Wrap(
                      spacing: 12,
                      children: ActivityCategory.values.asMap().entries.map(
                        (e) {
                          var index = e.key;
                          var catrgory = e.value;
                          return InkWell(
                            onTap: () {
                              main.setSelectedActivity(e.key);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  boxShadow: selected == index
                                      ? const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(2, -3),
                                            blurRadius: 5,
                                          )
                                        ]
                                      : null),
                              child: Text(
                                catrgory.name,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: selected == index
                                      ? AppColors.primary
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ),
            ),
          )
        ];
      }, body: Obx(() {
        final index = main.selectedActivity.value;
        return RefreshIndicator.adaptive(
          displacement: 10,
          backgroundColor: AppColors.primary,
          color: Platform.isIOS ? Colors.black : Colors.white,
          onRefresh: () async {
            activity.add(const ActivityGetRefreshEvent());
          },
          child: BlocConsumer<ActivityBloc, ActivityState>(
            listener: (context, state) {
              switch (state) {
                case ActivityPutLoadingState():
                  context.pop();
                  context.appDialogLoading(
                    dialogContent: const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: AppColors.primary,
                    ),
                  );
                  break;
                case ActivityPutSuccessState():
                  context.pop();
                  activity.add(const ActivityGetRefreshEvent());
                  reports.refundAmount.value = 0.0;
                  cashController.text = '';
                  context.appDialogText(
                    title: 'Payment Success',
                    message:
                        'Your payment was successful. Check the Payment completed menu for history.',
                  );

                  break;
                default:
              }
            },
            builder: (context, state) {
              switch (state) {
                case ActivityLoadingState():
                  return const ActivityShimmerLoadingWidget();
                case ActivityFailureState():
                  return const SizedBox.shrink();
                case ActivityErrorState():
                  return const SizedBox.shrink();
                case ActivityGetSuccessState():
                  List<ActivityEntity>? results =
                      filteredActivity(state.entity, index);

                  if (results != null) {
                    return ListView.builder(
                      itemCount: results.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: 14,
                          right: 16,
                          top: 16,
                          bottom: kToolbarHeight + 40),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: ActivityCardWidget(
                            isDetails: false,
                            entity: results[index],
                            onDetails: () {
                              showModalBottomSheet(
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
                                builder: (context) {
                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        bottom: context.viewInsetsBottom),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: ActivityCardWidget(
                                      entity: results[index],
                                      cashController: cashController,
                                      isDetails: true,
                                      onPay: () async {
                                        await onPay(results[index]);
                                      },
                                      onChanged: (value) {
                                        onChanged(value, results[index]);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.history,
                            size: 24.0,
                            color: Colors.grey,
                          ),
                          8.height,
                          "You have no activities."
                              .asSubtitleNormal(color: Colors.grey),
                          16.height,
                          SizedBox(
                            height: 40,
                            child: AppElevatedButtonWidget(
                              child: 'Refresh'.asSubtitleNormal(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              onPressed: () {
                                activity.add(const ActivityGetRefreshEvent());
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }

                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        );
      })),
    );
  }

  onChanged(value, ActivityEntity entity) {
    String sanitizedPrice = (value).replaceAll('.', '');
    double? customerCash = double.tryParse(sanitizedPrice);

    if (customerCash != null) {
      reports.cartBalance.value = reports.yourBalance.value;
      double total = entity.total?.toDouble() ?? 0.0;
      reports.refundAmount.value;

      debugPrint(" BALANCE ${reports.cartBalance.value}");
      reports.refundAmount.value = customerCash - total;
      reports.cartBalance.value =
          reports.cartBalance.value + total - reports.refundAmount.value;

      debugPrint("TOTAL $total");
      debugPrint("REFUND  ${reports.refundAmount.value}");
      debugPrint(" BALANCE ${reports.cartBalance.value}");
    }
  }

  Future<void> onPay(ActivityEntity entity) async {
    reports.yourBalance.value = reports.cartBalance.value;
    await AppPrefReports.saveEarnedToday(entity.total?.toDouble() ?? 0.0);
    await AppPrefReports.saveTotalEarned(entity.total?.toDouble() ?? 0.0);
    await AppPrefReports.saveYourBalance(reports.yourBalance.value);

    reports.cartBalance.value = 0.0;
    String sanitizedPrice = (cashController.text).replaceAll('.', '');
    double? customerCash = double.tryParse(sanitizedPrice);
    activity.add(
      ActivityPutEvent(
        models: ActivityModels(
          id: entity.id,
          cash: customerCash,
          isPay: true,
          refundAmount: reports.refundAmount.value,
        ),
      ),
    );
  }

  filteredActivity(ListActivityEntity? data, int index) {
    if (data != null) {
      return data.activity?.where((product) {
        return product.isPay == ActivityCategory.values[index].isPay;
      }).toList();
    }
  }
}
