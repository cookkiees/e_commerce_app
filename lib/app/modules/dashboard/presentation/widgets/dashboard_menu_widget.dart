import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/app_menu_rail_widget.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../main/controllers/main_controller.dart';
import '../extensions/dashboard_menu_extension.dart';

class DashboardMenuWidget extends StatelessWidget {
  const DashboardMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.put(MainController());

    return Container(
      margin: const EdgeInsets.only(right: 12, top: kToolbarHeight, left: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                toolbarHeight: kIsWeb ? 40 : 0,
                flexibleSpace: Container(
                  height: 48,
                  width: double.infinity,
                  color: AppColors.primary,
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "MENU".asSubtitleBig(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];
          },
          body: ListView.builder(
            itemCount: DashboardMenu.values.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.hardEdge,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  mainController.setMenuIndex(index);
                },
                child: Obx(
                  () => AppMenuRailWidget(
                    isSelected: mainController.menuIndex.value == index,
                    label: DashboardMenu.values[index].name,
                    icon: DashboardMenu.values[index].icon,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
