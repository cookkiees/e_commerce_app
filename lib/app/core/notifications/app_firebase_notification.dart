import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../constants/app_constants.dart';
import '../helpers/app_logger.dart';
import 'app_local_notification.dart';

class AppFirebaseNotification {
  AppFirebaseNotification._();
  static final AppFirebaseNotification _instance = AppFirebaseNotification._();
  static AppFirebaseNotification get instance => _instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    final settings = await firebaseMessaging.requestPermission();

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        String? fcmToken;
        if (kIsWeb) {
          fcmToken = await FirebaseMessaging.instance
              .getToken(vapidKey: AppConstants.vapidKey);
        } else {
          fcmToken = await FirebaseMessaging.instance.getToken();
        }
        debugPrint('FCM Token: $fcmToken');
        break;
      case AuthorizationStatus.denied:
        debugPrint('Notification permission denied by the user.');
        break;
      case AuthorizationStatus.notDetermined:
        debugPrint('Notification permission not determined.');
        break;
      case AuthorizationStatus.provisional:
        debugPrint('Provisional notification authorization.');
        break;
    }
  }

  Future initPushNotification() async {
    FirebaseMessaging.onBackgroundMessage(messagingBackgroundHandler);
    await FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    if (kIsWeb) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');
        if (message.notification != null) {
          log('Message also contained a notification: ${message.notification}');
        }
      });
    }
    FirebaseMessaging.onMessage.listen((event) async {
      await AppLocalNotification.instance.pushNotification(event);
    });
  }

  Future<void> messagingBackgroundHandler(RemoteMessage message) async {
    log("ID : ${message.messageId}");
  }

  dynamic data;
  void handleMessage(RemoteMessage? message) {
    if (kDebugMode) {
      if (message != null) {
        AppLogger.logNotif("ID : ${message.messageId}");
        AppLogger.logNotif("Data : ${message.data}");
        AppLogger.logNotif("Category : ${message.category}");
        AppLogger.logNotif("Notification : ${message.notification}");
        AppLogger.logNotif("Body : ${message.notification?.body ?? ''}");
        AppLogger.logNotif("Collapse Key : ${message.collapseKey}");
        AppLogger.logNotif("From : ${message.from}");
        AppLogger.logNotif("Message Type : ${message.messageType}");
        AppLogger.logNotif("Content Available : ${message.contentAvailable}");
        AppLogger.logNotif("Mutable Content : ${message.mutableContent}");
        AppLogger.logNotif("Sender ID : ${message.senderId}");
        AppLogger.logNotif("Send Time : ${message.sentTime}");
        AppLogger.logNotif("Thread ID : ${message.threadId}");
        AppLogger.logNotif("TTL : ${message.ttl}");
        data = message.data;
      }
    }
  }
}
