import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/helpers/app_prefs.dart';

class DashboardController extends GetxController {
  RxDouble totalOrders = 0.0.obs;
  RxDouble earnedToday = 0.0.obs;
  RxDouble totalEraned = 0.0.obs;
  RxDouble yourBalance = 0.0.obs;
  RxDouble remainingBalance = 0.0.obs;
  RxDouble refundAmount = 0.0.obs;
  RxDouble cartBalance = 0.0.obs;

  Future<void> loadReportsData() async {
    final prefs = await SharedPreferences.getInstance();
    earnedToday.value = prefs.getDouble(AppPrefReports.earnedTodayKey) ?? 0.0;
    totalEraned.value = prefs.getDouble(AppPrefReports.totalEarnedKey) ?? 0.0;
    totalOrders.value = prefs.getDouble(AppPrefReports.totalOrderKey) ?? 0.0;
    yourBalance.value = prefs.getDouble(AppPrefReports.yourBalance) ?? 0.0;
  }

  @override
  void onInit() {
    super.onInit();
    loadReportsData();
  }
}
