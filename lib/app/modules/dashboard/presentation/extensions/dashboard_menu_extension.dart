import 'package:flutter/material.dart';

enum DashboardMenu {
  dashboard,
  notification,
}

extension DashboardMenuExtension on DashboardMenu {
  String get name {
    switch (this) {
      case DashboardMenu.dashboard:
        return 'DASHBOARD';
      case DashboardMenu.notification:
        return 'NOTIFICATIONS';
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case DashboardMenu.dashboard:
        return Icons.dashboard_outlined;

      case DashboardMenu.notification:
        return Icons.notifications_outlined;

      default:
        return Icons.person_outline;
    }
  }
}
