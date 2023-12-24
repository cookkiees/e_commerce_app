// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBWTtEDfxHZ9tpKSSPOdAFX6xMEP2_ab1Y',
    appId: '1:557758569910:web:eb6aef4b299fd4fa36f517',
    messagingSenderId: '557758569910',
    projectId: 'e-commerce-app-crackers',
    authDomain: 'e-commerce-app-crackers.firebaseapp.com',
    storageBucket: 'e-commerce-app-crackers.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcuBYUNOm2_cISfriOol3AzJxca2aMYdM',
    appId: '1:557758569910:android:bfcceea7c4161e1936f517',
    messagingSenderId: '557758569910',
    projectId: 'e-commerce-app-crackers',
    storageBucket: 'e-commerce-app-crackers.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATCrVgc8dOuz07-oMUsEpTFYnZHuyhu1k',
    appId: '1:557758569910:ios:912223b62665ee9036f517',
    messagingSenderId: '557758569910',
    projectId: 'e-commerce-app-crackers',
    storageBucket: 'e-commerce-app-crackers.appspot.com',
    iosBundleId: 'com.example.eCommerceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyATCrVgc8dOuz07-oMUsEpTFYnZHuyhu1k',
    appId: '1:557758569910:ios:7e154cf3863366f736f517',
    messagingSenderId: '557758569910',
    projectId: 'e-commerce-app-crackers',
    storageBucket: 'e-commerce-app-crackers.appspot.com',
    iosBundleId: 'com.example.eCommerceApp.RunnerTests',
  );
}