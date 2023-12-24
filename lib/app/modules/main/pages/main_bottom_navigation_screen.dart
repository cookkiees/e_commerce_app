// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../config/themes/app_colors.dart';
import '../controllers/main_controller.dart';

class MainBottomNavigationScreen extends StatelessWidget {
  const MainBottomNavigationScreen({
    super.key,
    required this.navShell,
  });
  final StatefulNavigationShell navShell;

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.put(MainController());

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          navShell,
          GetBuilder(
            init: mainController,
            builder: (context) {
              return Obx(
                () {
                  if (mainController.isHideBottomNav.value == true) {
                    return const SizedBox.shrink();
                  } else {
                    return FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Theme(
                        data: ThemeData(splashFactory: NoSplash.splashFactory),
                        child: BottomNavigationBar(
                          landscapeLayout:
                              BottomNavigationBarLandscapeLayout.centered,
                          unselectedLabelStyle: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                          unselectedItemColor: Colors.grey,
                          selectedFontSize: 10,
                          selectedItemColor: AppColors.primary,
                          selectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                          ),
                          backgroundColor: Colors.white,
                          currentIndex: navShell.currentIndex,
                          type: BottomNavigationBarType.fixed,
                          onTap: _onTap,
                          items: _builItems(),
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _onTap(index) {
    navShell.goBranch(
      index,
      initialLocation: index == navShell.currentIndex,
    );
  }

  List<BottomNavigationBarItem> _builItems() {
    return [
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.local_fire_department),
        icon: Icon(Icons.local_fire_department_outlined),
        label: 'STORE',
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.fastfood, size: 22),
        icon: Icon(Icons.fastfood_outlined, size: 22),
        label: 'PRODUCTS',
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.history),
        icon: Icon(Icons.history_outlined),
        label: 'ACTICITY',
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.people_alt),
        icon: Icon(Icons.people_alt_outlined),
        label: 'CUSTOMERS',
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.person),
        icon: Icon(Icons.person_outline),
        label: 'PROFILE',
      ),
    ];
  }
}
