import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static Future<bool> saveServerAuthCode(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('auth-code', value);
  }

  static Future<bool> saveEmail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('email', value);
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('email');
    return '$token';
  }

  static Future<bool> removeEmail() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.remove('email');
  }
}

class AppPrefReports {
  static const String totalOrderKey = 'total_order';
  static const String earnedTodayKey = 'earned_today';
  static const String totalEarnedKey = 'total_earned';
  static const String yourBalance = 'your_balance';

  static Future<bool> saveYourBalance(double value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(yourBalance, value);
  }

  static Future<bool> saveTotalOrder(double value) async {
    final prefs = await SharedPreferences.getInstance();
    double currentTotalOrder = prefs.getDouble(totalOrderKey) ?? 0.0;
    double updatedTotalOrder = currentTotalOrder + value;
    return prefs.setDouble(totalOrderKey, updatedTotalOrder);
  }

  static Future<bool> saveEarnedToday(double value) async {
    final prefs = await SharedPreferences.getInstance();
    double currentEarnedToday = prefs.getDouble(earnedTodayKey) ?? 0.0;
    double updatedEarnedToday = currentEarnedToday + value;
    return prefs.setDouble(earnedTodayKey, updatedEarnedToday);
  }

  static Future<bool> saveTotalEarned(double value) async {
    final prefs = await SharedPreferences.getInstance();
    double currentTotalEarned = prefs.getDouble(totalEarnedKey) ?? 0.0;
    double updatedTotalEarned = currentTotalEarned + value;
    return prefs.setDouble(totalEarnedKey, updatedTotalEarned);
  }

  static Future<double> getTotalOrder() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(totalOrderKey) ?? 0.0;
  }

  static Future<double> getYourBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(yourBalance) ?? 0.0;
  }

  static Future<double> getEarnedToday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(earnedTodayKey) ?? 0.0;
  }

  static Future<double> getTotalEarned() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(totalEarnedKey) ?? 0.0;
  }

  static Future<bool> resetTotalEarned() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(totalEarnedKey, 0.0);
  }

  static Future<bool> resetYourBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(yourBalance, 0.0);
  }

  static Future<bool> resetTotalOrder() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(totalOrderKey, 0.0);
  }

  static Future<bool> resetEarnedToday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(earnedTodayKey, 0.0);
  }

  static Future<bool> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now();
    final resetTime = DateTime(
        currentTime.year, currentTime.month, currentTime.day, 23, 0, 0);

    if (currentTime.isAfter(resetTime) &&
        prefs.getString('last_reset_date') != currentTime.toIso8601String()) {
      prefs.setDouble(earnedTodayKey, 0.0);
      prefs.setDouble(yourBalance, 0.0);
      prefs.setString('last_reset_date', currentTime.toIso8601String());
      return true;
    }

    return false;
  }
}
