import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'app/config/routers/app_router.dart';
import 'app/config/routers/app_routes.dart';
import 'app/config/themes/app_theme.dart';
import 'app/core/helpers/app_logger.dart';
import 'app/core/helpers/app_prefs.dart';
import 'firebase_options.dart';

void main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  WidgetsFlutterBinding.ensureInitialized();
  const Settings(persistenceEnabled: true);
  try {
    await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform)
        .then((value) => AppLogger.logInfo("Connected Firebase"))
        .catchError((e) => AppLogger.logInfo(e.toString()));
    // await AppLocalNotification.instance.requestNotification();
    // await AppFirebaseNotification.instance.initNotification();
    // await AppFirebaseNotification.instance.initPushNotification();
    var email = await AppPrefs.getEmail();
    runApp(MyApp(email: AppRouter.determineInitialRoute(email)));
  } catch (e) {
    runApp(MyAppStartupErrorWidget(error: e));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.defaults(),
      routerConfig: AppRouter.router(email ?? AppRoutes.authentication.path),
    );
  }
}

class MyAppStartupErrorWidget extends StatelessWidget {
  final dynamic error;

  const MyAppStartupErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Error during app startup:\n$error',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
