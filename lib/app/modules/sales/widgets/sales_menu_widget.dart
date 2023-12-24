import 'package:e_commerce_app/app/common/extensions/app_text_extension.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/app_menu_rail_widget.dart';
import '../../../config/themes/app_colors.dart';
import '../../extensions/menu_category_extension.dart';
import '../../main/controllers/main_controller.dart';

class SalesMenuWidget extends StatelessWidget {
  const SalesMenuWidget({super.key});

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
                toolbarHeight: 0,
                flexibleSpace: Container(
                  width: double.infinity,
                  color: AppColors.primary,
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "SALES".asSubtitleBig(
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
            itemCount: MenuCategory.values.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.hardEdge,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  mainController.setStoreIndex(index);
                },
                child: Obx(
                  () => AppMenuRailWidget(
                    isSelected: mainController.storeIndex.value == index,
                    label: MenuCategory.values[index].name,
                    icon: MenuCategory.values[index].icon,
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
