import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:e_commerce_app/app/modules/dashboard/presentation/extensions/dashboard_menu_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../main/controllers/main_controller.dart';
import '../dashboard/views/dashboard_views.dart';
import '../notifications/views/notifications_views.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen(
      {super.key, this.onPressedPanelRight, this.onPressedPanelLeft});

  final void Function()? onPressedPanelRight;
  final void Function()? onPressedPanelLeft;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  MainController main = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 1,
        elevation: 1,
        shadowColor: Colors.black38,
        centerTitle: false,
        title: Obx(
          () => FadeIn(
            child:
                DashboardMenu.values[main.menuIndex.value].name.asSubtitleBig(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: widget.onPressedPanelRight,
              child: Icon(
                Icons.person_outline,
                size: 24,
                color: AppColors.primary.withOpacity(0.8),
              ),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: widget.onPressedPanelLeft,
          icon: const Icon(
            Icons.subject,
            size: 24.0,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Obx(
        () {
          switch (main.menuIndex.value) {
            case 0:
              return const DashboardViews();
            case 1:
              return const NotificationsViews();

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
