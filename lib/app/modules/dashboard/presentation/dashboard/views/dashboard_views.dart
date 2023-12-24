import 'package:e_commerce_app/app/common/extensions/app_carrency_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/common/utils/app_alert_dialog.dart';
import 'package:e_commerce_app/app/common/utils/app_snackbar.dart';
import 'package:e_commerce_app/app/core/helpers/app_prefs.dart';
import 'package:e_commerce_app/app/modules/dashboard/presentation/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../components/app_elevated_button_widget.dart';
import '../../../../../components/app_text_form_field_widget.dart';
import '../../../../../config/themes/app_colors.dart';
import '../../../../profile/presentation/bloc/profile_bloc.dart';
import '../widgets/dashboard_popupmenu_earned_today.dart';
import '../widgets/dashboard_popupmenu_total_earned.dart';
import '../widgets/dashboard_popupmenu_total_orders.dart';
import '../widgets/dashboard_popupmenu_your_balance.dart';

class DashboardViews extends StatefulWidget {
  const DashboardViews(
      {super.key, this.onPressedPanelRight, this.onPressedPanelLeft});

  final void Function()? onPressedPanelRight;
  final void Function()? onPressedPanelLeft;

  @override
  State<DashboardViews> createState() => _DashboardViewsState();
}

class _DashboardViewsState extends State<DashboardViews> {
  var balanceController = TextEditingController();
  var withdrawelController = TextEditingController();
  final currentTime = DateTime.now();

  DashboardController reports = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    var userBloc = BlocProvider.of<ProfileBloc>(context);
    userBloc.add(const ProfileUserEvent());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        height: 160,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle,
                                    image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      scale: 1,
                                      image: AssetImage(
                                          'assets/images/user_photo.jpg'),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(2, 3),
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                ),
                                12.width,
                                BlocBuilder<ProfileBloc, ProfileState>(
                                  builder: (context, state) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          '${state.user?.displayName}'
                                              .asSubtitleBig(
                                            fontWeight: FontWeight.w400,
                                          ),
                                          '${state.user?.email}'
                                              .asSubtitleSmall(
                                            color: Colors.grey,
                                          ),
                                          4.height,
                                          if (state.user?.isEmailVerified ??
                                              true)
                                            const Icon(
                                              Icons.verified_outlined,
                                              size: 20.0,
                                              color: Colors.blue,
                                            )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            12.height,
                            Row(
                              children: [
                                Obx(
                                  () => SizedBox(
                                    width: 100,
                                    child: _buildContainer(
                                      alignment: Alignment.centerLeft,
                                      title: 'Your balance',
                                      value: formatAsCurrency(
                                          reports.yourBalance.value),
                                      icon: Shimmer.fromColors(
                                        baseColor: Colors.green,
                                        highlightColor: Colors.white,
                                        child: const Icon(
                                          Icons.account_balance_wallet_outlined,
                                          size: 16.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      popupMenu: popupMenuYourBalance,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                8.width,
                                Obx(
                                  () => SizedBox(
                                    width: 100,
                                    child: _buildContainer(
                                      alignment: Alignment.centerLeft,
                                      title: 'Total earned',
                                      value: formatAsCurrency(
                                          reports.totalEraned.value),
                                      icon: Shimmer.fromColors(
                                        baseColor: Colors.green,
                                        highlightColor: Colors.white,
                                        child: const Icon(
                                          Icons.call_made,
                                          size: 16.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      popupMenu: _popupMenuTotalEarned,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 160,
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => _buildContainer(
                                alignment: Alignment.centerLeft,
                                title: 'Total Orders',
                                value: '${reports.totalOrders.value.toInt()}',
                                icon: Shimmer.fromColors(
                                  baseColor: Colors.green,
                                  highlightColor: Colors.white,
                                  child: const Icon(
                                    Icons.fact_check_outlined,
                                    size: 17.0,
                                    color: Colors.green,
                                  ),
                                ),
                                popupMenu: _popupMenuTotalOrders,
                              ),
                            ),
                            Obx(
                              () => _buildContainer(
                                alignment: Alignment.centerLeft,
                                title: 'Earned today',
                                value:
                                    formatAsCurrency(reports.earnedToday.value),
                                icon: Shimmer.fromColors(
                                  baseColor: Colors.green,
                                  highlightColor: Colors.white,
                                  child: const Icon(
                                    Icons.trending_up,
                                    size: 16.0,
                                    color: Colors.green,
                                  ),
                                ),
                                popupMenu: _popupMenuEarnedToday,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   margin: const EdgeInsets.only(right: 12, top: 24),
                //   child: const BarChartWeekOrder(),
                // ),
                // Container(
                //   margin: const EdgeInsets.only(right: 12, top: 24),
                //   child: DasboardBarChartTotalEarnedWidget(),
                // ),
                // const SizedBox(height: kToolbarHeight - 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuEarnedTodayWidget get _popupMenuEarnedToday =>
      PopupMenuEarnedTodayWidget(
        onSelected: (selected) async {
          final resetStartTime = DateTime(
              currentTime.year, currentTime.month, currentTime.day, 8, 0);
          final resetEndTime = DateTime(
              currentTime.year, currentTime.month, currentTime.day, 9, 0);
          switch (selected) {
            case PopupMenuActionEarnedToday.reset:
              if (currentTime.isAfter(resetStartTime) &&
                  currentTime.isBefore(resetEndTime)) {
                context.appAlertReportsDialog(
                  title: 'RESET TOTAL EARNED?',
                  content:
                      'Are your sure to reset Your Balance??.\nReset is only allowed on the 28th day between 8 AM and 9 AM.',
                  onReset: () async {
                    await AppPrefReports.resetEarnedToday();
                    reports.earnedToday.value =
                        await AppPrefReports.getEarnedToday();
                    if (mounted) {
                      context.pop();
                    }
                  },
                );
              } else {
                context.appSnackbar(
                  content: 'Reset is only allowed between 8 AM and 9 AM.'
                      .asSubtitleNormal(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              break;
            default:
          }
        },
      );

  PopupMenuTotalEarnedWidget get _popupMenuTotalEarned =>
      PopupMenuTotalEarnedWidget(
        onSelected: (selected) async {
          final resetStartTime = DateTime(
              currentTime.year, currentTime.month, currentTime.day, 8, 0);
          final resetEndTime = DateTime(
              currentTime.year, currentTime.month, currentTime.day, 9, 0);
          switch (selected) {
            case PopupMenuActionTotalEarned.reset:
              if (currentTime.day == 28 &&
                  currentTime.isAfter(resetStartTime) &&
                  currentTime.isBefore(resetEndTime)) {
                context.appAlertReportsDialog(
                  title: 'RESET TOTAL EARNED?',
                  content:
                      'Are your sure to reset Your Balance??.\nReset is only allowed on the 28th day between 8 AM and 9 AM.',
                  onReset: () async {
                    await AppPrefReports.resetTotalEarned();
                    reports.totalEraned.value =
                        await AppPrefReports.getTotalEarned();
                    if (mounted) {
                      context.pop();
                    }
                  },
                );
              } else {
                context.appSnackbar(
                  content:
                      'Reset is only allowed on the 28th day between 8 AM and 9 AM.'
                          .asSubtitleNormal(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              break;
            default:
          }
        },
      );

  PopupMenuYourBalanceWidget get popupMenuYourBalance =>
      PopupMenuYourBalanceWidget(
        onSelected: (selected) async {
          final resetStartTime = DateTime(
              currentTime.year, currentTime.month, currentTime.day, 8, 0);
          final resetEndTime = DateTime(
              currentTime.year, currentTime.month, currentTime.day, 9, 0);
          switch (selected) {
            case PopupMenuActionYourBalance.edit:
              _buildAppShowBottom(context);
              break;
            case PopupMenuActionYourBalance.withdrawal:
              _buildAppShowBottomWithdrawel(context);
              break;
            case PopupMenuActionYourBalance.reset:
              if (currentTime.isAfter(resetStartTime) &&
                  currentTime.isBefore(resetEndTime)) {
                context.appAlertReportsDialog(
                  title: 'RESET YOUR BALANCE?',
                  content:
                      'Are your sure to reset Your Balance??.\nReset is only allowed between 8 AM and 9 AM.',
                  onReset: () async {
                    await AppPrefReports.resetYourBalance();
                    reports.yourBalance.value =
                        await AppPrefReports.getYourBalance();
                    if (mounted) {
                      context.pop();
                    }
                  },
                );
              } else {
                context.appSnackbar(
                  content: 'Reset is only allowed between 8 AM and 9 AM.'
                      .asSubtitleNormal(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              break;
            default:
          }
        },
      );

  PopupMenuTotalOrdersWidget get _popupMenuTotalOrders =>
      PopupMenuTotalOrdersWidget(
        onSelected: (selected) async {
          final resetStartTime = DateTime(
              currentTime.year, currentTime.month, currentTime.day, 8, 0);
          final resetEndTime = DateTime(
              currentTime.year, currentTime.month, currentTime.day, 9, 0);
          switch (selected) {
            case PopupMenuActionTotalOrders.reset:
              if (currentTime.day == 28 &&
                  currentTime.isAfter(resetStartTime) &&
                  currentTime.isBefore(resetEndTime)) {
                context.appAlertReportsDialog(
                  title: 'RESET TOTAL ORDERS?',
                  content:
                      'Are your sure to reset Your Balance??.\nReset is only allowed on the 28th day between 8 AM and 9 AM.',
                  onReset: () async {
                    await AppPrefReports.resetTotalOrder();
                    if (mounted) {
                      context.pop();
                    }
                  },
                );
              } else {
                context.appSnackbar(
                  content:
                      'Reset is only allowed on the 28th day between 8 AM and 9 AM.'
                          .asSubtitleNormal(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              break;
            default:
          }
        },
      );

  _buildAppShowBottom(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.white,
        showDragHandle: true,
        builder: (context) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: context.viewInsetsBottom),
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                'Your Balance'.asSubtitleNormal(
                  fontWeight: FontWeight.w400,
                ),
                8.height,
                SizedBox(
                  height: 44,
                  child: AppTextFormFieldWidget(
                    maxLines: 1,
                    hintText: 'Your Balance',
                    controller: balanceController,
                    inputFormatters: [CurrencyInputFormatter()],
                    onChanged: (value) {},
                  ),
                ),
                8.height,
                'Your balance will be reduced by the change amount and reset to zero every day.'
                    .asSubtitleNormal(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                24.height,
                SizedBox(
                  height: 44,
                  width: double.infinity,
                  child: AppElevatedButtonWidget(
                    onPressed: () async {
                      String sanitizedBalance =
                          (balanceController.text).replaceAll('.', '');
                      final balance = double.tryParse(sanitizedBalance);
                      if (balance != null) {
                        var finalBalance = balance + reports.yourBalance.value;
                        await AppPrefReports.saveYourBalance(finalBalance);
                        reports.yourBalance.value =
                            await AppPrefReports.getYourBalance();
                      }
                      if (mounted) {
                        context.pop();
                      }
                    },
                    child: 'SAVE'.asSubtitleNormal(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: kToolbarHeight)
              ],
            ),
          );
        });
  }

  _buildAppShowBottomWithdrawel(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: context.viewInsetsBottom),
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'WITHDRAWEL'.asSubtitleBig(
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
              const Divider(thickness: 0.5),
              12.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Your Balance'.asSubtitleNormal(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                  formatAsCurrency(reports.yourBalance.value).asSubtitleNormal(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ],
              ),
              12.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: 'Amount'.asSubtitleNormal(
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 44,
                      child: AppTextFormFieldWidget(
                        maxLines: 1,
                        hintText: 'Enter amount',
                        controller: withdrawelController,
                        inputFormatters: [CurrencyInputFormatter()],
                        onChanged: (value) {
                          String sanitizedPrice = (value).replaceAll('.', '');
                          double? withdrawelCash =
                              double.tryParse(sanitizedPrice);

                          if (withdrawelCash != null) {
                            reports.remainingBalance.value =
                                reports.yourBalance.value - withdrawelCash;
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              const Divider(thickness: 0.5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Unspent Balance'.asSubtitleNormal(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                  Obx(
                    () => formatAsCurrency(reports.remainingBalance.value)
                        .asSubtitleNormal(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              24.height,
              SizedBox(
                height: 44,
                width: double.infinity,
                child: AppElevatedButtonWidget(
                  onPressed: () async {
                    await AppPrefReports.saveYourBalance(
                        reports.remainingBalance.value);

                    reports.yourBalance.value =
                        await AppPrefReports.getYourBalance();
                    if (mounted) {
                      context.pop();
                    }
                  },
                  child: 'SAVE'.asSubtitleNormal(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: kToolbarHeight - 20)
            ],
          ),
        );
      },
    );
  }

  Widget _buildContainer(
      {required Widget icon,
      required String title,
      required String value,
      AlignmentGeometry? alignment,
      required Widget popupMenu}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: alignment ?? Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: icon,
              ),
              4.height,
              value.asSubtitleBig(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
              ),
              4.height,
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(height: 24, width: 24, child: popupMenu),
        )
      ],
    );
  }
}
