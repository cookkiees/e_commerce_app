import 'package:e_commerce_app/app/layout/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/app/modules/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/app/modules/authentication/presentation/pages/authentication_forgot_password_screen.dart';
import 'package:e_commerce_app/app/modules/camera/pages/camera_screen.dart';
import 'package:e_commerce_app/app/modules/profile/presentation/bloc/profile_bloc.dart';
import 'package:e_commerce_app/app/modules/profile/presentation/pages/profile_update_screen.dart';
import 'package:e_commerce_app/app/modules/sales/pages/sales_category_screen.dart';
import 'package:go_router/go_router.dart';

import '../../modules/activity/presentation/bloc/activity_bloc.dart';
import '../../modules/activity/presentation/pages/activity_screen.dart';
import '../../modules/authentication/presentation/pages/authentication_screen.dart';
import '../../modules/customers/presentation/bloc/customers_bloc.dart';
import '../../modules/customers/presentation/pages/customers_screen.dart';
import '../../modules/main/pages/main_bottom_navigation_screen.dart';
import '../../modules/main/pages/main_rail_navigation_screen.dart';
import '../../modules/products/presentation/bloc/products_bloc.dart';
import '../../modules/products/presentation/pages/products_create_screen.dart';
import '../../modules/products/presentation/pages/products_screen.dart';
import '../../modules/profile/presentation/pages/profile_screen.dart';
import 'app_routes.dart';

mixin class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static String determineInitialRoute(String? email) {
    if (email != null && email.isNotEmpty && email != 'null') {
      return AppRoutes.main.path;
    } else {
      return AppRoutes.authentication.path;
    }
  }

  static router(String initialRoute) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          name: AppRoutes.authentication.name,
          path: AppRoutes.authentication.path,
          builder: (contex, state) => BlocProvider(
            create: (context) => AuthBloc(),
            child: const AuthenticationScreen(),
          ),
        ),
        GoRoute(
          name: AppRoutes.forgotPassword.name,
          path: AppRoutes.forgotPassword.path,
          builder: (contex, state) => BlocProvider(
            create: (context) => AuthBloc(),
            child: const AuthenticationForgotPasswordScreen(),
          ),
        ),
        GoRoute(
          name: AppRoutes.category.name,
          path: AppRoutes.category.path,
          builder: (contex, state) => const SalesCategoryScreen(),
        ),
        _statefulSheelRoute()
      ],
    );
  }

  static StatefulShellRoute _statefulSheelRoute() {
    return StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ResponsiveLayout(
          phone: MainBottomNavigationScreen(navShell: navigationShell),
          tablet: MainBottomNavigationScreen(navShell: navigationShell),
          largeTablet: MainBottomNavigationScreen(navShell: navigationShell),
          computer: MainBottomNavigationScreen(navShell: navigationShell),
        );
      },
      branches: _buildBranches(),
    );
  }

  static List<StatefulShellBranch> _buildBranches() {
    return [
      _statefulShellHome(),
      _statefulShellProducts(),
      _statefulShellReports(),
      _statefulShellCustomers(),
      _statefulShellProfile(),
    ];
  }

  static StatefulShellBranch _statefulShellHome() {
    return StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.main.name,
          path: AppRoutes.main.path,
          builder: (context, state) => const MainRailNavigationScreen(),
          routes: [
            GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: AppRoutes.profileUpdate.name,
              path: AppRoutes.profileUpdate.name,
              builder: (context, state) {
                final user = state.extra as Map<String, dynamic>;
                return BlocProvider(
                  create: (context) => ProfileBloc(),
                  child: ProfileUpdateScreen(
                    userEmail: user['user_email'],
                    username: user['username'],
                    userPhoneNumber: user['user_phone_number'],
                  ),
                );
              },
            )
          ],
        )
      ],
    );
  }

  static StatefulShellBranch _statefulShellProducts() {
    return StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.products.name,
          path: AppRoutes.products.path,
          builder: (context, state) => BlocProvider(
            create: (context) => ProductsBloc(),
            child: const ProductsScreen(),
          ),
          routes: [
            GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: AppRoutes.productsCreate.name,
              path: AppRoutes.productsCreate.name,
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => ProductsBloc(),
                  child: const ProductsCreateScreen(),
                );
              },
            ),
            GoRoute(
              parentNavigatorKey: rootNavigatorKey,
              name: AppRoutes.camera.name,
              path: AppRoutes.camera.name,
              builder: (context, state) {
                return const CameraScreen();
              },
            )
          ],
        )
      ],
    );
  }

  static StatefulShellBranch _statefulShellReports() {
    return StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.activity.name,
          path: AppRoutes.activity.path,
          builder: (context, state) => BlocProvider(
            create: (context) => ActivityBloc(),
            child: const ActivityScreen(),
          ),
        )
      ],
    );
  }

  static StatefulShellBranch _statefulShellCustomers() {
    return StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.customers.name,
          path: AppRoutes.customers.path,
          builder: (context, state) => BlocProvider(
            create: (context) => CustomersBloc(),
            child: const CustomersScreen(),
          ),
        )
      ],
    );
  }

  static StatefulShellBranch _statefulShellProfile() {
    return StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.profile.name,
          path: AppRoutes.profile.path,
          builder: (context, state) => BlocProvider(
            create: (context) => ProfileBloc(),
            child: const ProfileScreen(
              isScreenBottombar: false,
            ),
          ),
        )
      ],
    );
  }
}
