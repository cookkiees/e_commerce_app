import 'package:e_commerce_app/app/common/extensions/app_size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/themes/app_colors.dart';
import '../../dashboard/presentation/widgets/dashboard_menu_widget.dart';
import '../../sales/widgets/sales_menu_widget.dart';
import '../controllers/main_controller.dart';

class MainRailNavigationWidget extends StatelessWidget {
  const MainRailNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.put(MainController());
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 12),
          margin: const EdgeInsets.only(top: kToolbarHeight, left: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  mainController.setRailNavIndex(0);
                },
                child: Obx(() {
                  if (mainController.railNavIndex.value == 0) {
                    return const Icon(
                      Icons.widgets,
                      size: 24.0,
                      color: AppColors.primary,
                    );
                  } else {
                    return const Icon(
                      Icons.widgets_outlined,
                      size: 24.0,
                      color: Colors.grey,
                    );
                  }
                }),
              ),
              24.height,
              InkWell(
                onTap: () {
                  mainController.setRailNavIndex(1);
                },
                child: Obx(() {
                  if (mainController.railNavIndex.value == 1) {
                    return const Icon(
                      Icons.store,
                      size: 24.0,
                      color: AppColors.primary,
                    );
                  } else {
                    return const Icon(
                      Icons.store_outlined,
                      size: 24.0,
                      color: Colors.grey,
                    );
                  }
                }),
              ),
            ],
          ),
        ),
        Obx(() {
          switch (mainController.railNavIndex.value) {
            case 0:
              return const Flexible(
                child: DashboardMenuWidget(),
              );
            case 1:
              return const Flexible(
                child: SalesMenuWidget(),
              );

            default:
              return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
