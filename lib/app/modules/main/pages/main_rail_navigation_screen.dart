import 'package:e_commerce_app/app/modules/activity/presentation/bloc/activity_bloc.dart';
import 'package:e_commerce_app/app/modules/customers/presentation/bloc/customers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import '../../../components/app_shadow_widget.dart';
import '../../../layout/inner_drawer_layout.dart';
import '../../dashboard/presentation/pages/dashboard_screen.dart';
import '../../main/controllers/main_controller.dart';
import '../../main/widgets/main_rail_navigation_widget.dart';
import '../../products/presentation/bloc/products_bloc.dart';
import '../../profile/presentation/bloc/profile_bloc.dart';
import '../../profile/presentation/pages/profile_screen.dart';
import '../../sales/pages/sales_screen.dart';
import '../../carts/pages/carts_screen.dart';

class MainRailNavigationScreen extends StatelessWidget {
  const MainRailNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<InnerDrawerState> innerDrawerKey =
        GlobalKey<InnerDrawerState>();
    final mainController = Get.put(MainController());
    void openPanelLeft() {
      innerDrawerKey.currentState
          ?.toggle(direction: InnerDrawerDirection.start);
    }

    void openPanelRight() {
      innerDrawerKey.currentState?.toggle(direction: InnerDrawerDirection.end);
    }

    return InnerDrawerLayout(
      key: innerDrawerKey,
      onTapClose: true,
      swipe: true,
      colorTransitionChild: Colors.grey.shade200,
      colorTransitionScaffold: Colors.transparent,
      offset: const IDOffset.horizontal(0.7),
      scale: const IDOffset.horizontal(1),
      proportionalChildArea: true,
      swipeChild: true,
      borderRadius: 8,
      boxShadow: appShadowWidget(),
      leftAnimationType: InnerDrawerAnimation.static,
      rightAnimationType: InnerDrawerAnimation.quadratic,
      backgroundDecoration: BoxDecoration(
        color: Colors.grey.shade200,
        // gradient: const LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     AppColors.primary,
        //     AppColors.primary,
        //     AppColors.secondary,
        //     AppColors.secondary,
        //   ],
        // ),
      ),
      innerDrawerCallback: (isDrawerOpen) {
        mainController.setHideBottomNav(!isDrawerOpen);
      },
      leftChild: const MainRailNavigationWidget(),
      rightChild: Obx(
        () {
          switch (mainController.railNavIndex.value) {
            case 0:
              return BlocProvider(
                create: (context) => ProfileBloc(),
                child: const ProfileScreen(
                  isScreenBottombar: true,
                ),
              );
            case 1:
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ActivityBloc(),
                  ),
                  BlocProvider(
                    create: (context) => CustomersBloc(),
                  ),
                ],
                child: const CartsScreen(),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      scaffold: Obx(
        () {
          switch (mainController.railNavIndex.value) {
            case 0:
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ProfileBloc(),
                  ),
                ],
                child: DashboardScreen(
                  onPressedPanelLeft: openPanelLeft,
                  onPressedPanelRight: openPanelRight,
                ),
              );
            case 1:
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ProductsBloc(),
                  ),
                ],
                child: SalesScreen(
                  onPressedPanelLeft: openPanelLeft,
                  onPressedPanelRight: openPanelRight,
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
