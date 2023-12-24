import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../helpers/app_logger.dart';

class AppLocalNotification {
  AppLocalNotification._();
  static final AppLocalNotification _instance = AppLocalNotification._();
  static AppLocalNotification get instance => _instance;
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> requestNotification() async {
    final settings = await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (settings != null) {
      AppLogger.logInfo(
        'Notification permissions granted: ${settings.runtimeType}',
      );
    }
  }

  void initilize(FlutterLocalNotificationsPlugin plugin) async {
    var initilizeAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initilizeIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initilizeAndroid,
      iOS: initilizeIOS,
      macOS: initilizeIOS,
    );
    await plugin.initialize(initializationSettings);
  }

  pushNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'Channel id',
      'channel_name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    int notificationId = Random().nextInt(100000);

    await notificationsPlugin.show(
      notificationId,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
    );
  }
}
