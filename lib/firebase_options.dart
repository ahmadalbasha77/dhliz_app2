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
    apiKey: 'AIzaSyADWJ5qdChL68HyR67-Sc8l8v7UH2l45f8',
    appId: '1:156415235765:web:19406717bd0d17b582d0fc',
    messagingSenderId: '156415235765',
    projectId: 'dhlizapp',
    authDomain: 'dhlizapp.firebaseapp.com',
    storageBucket: 'dhlizapp.appspot.com',
    measurementId: 'G-GPQYY1DBGB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJ3bC4h3RL1Gd3_3X8FoXEXiVLm02sw2I',
    appId: '1:156415235765:android:dda3a46483a1a16c82d0fc',
    messagingSenderId: '156415235765',
    projectId: 'dhlizapp',
    storageBucket: 'dhlizapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAINenukbxgu9GNkMM6CIKdHxGM5Zqfb0E',
    appId: '1:156415235765:ios:1d800a907c4c1a1382d0fc',
    messagingSenderId: '156415235765',
    projectId: 'dhlizapp',
    storageBucket: 'dhlizapp.appspot.com',
    androidClientId: '156415235765-2ga5u9mjf4sch8ttf37h2cboueoc3d2e.apps.googleusercontent.com',
    iosClientId: '156415235765-cu8hid0em092vphrv3f57s93bh83c29i.apps.googleusercontent.com',
    iosBundleId: 'com.fuais.dhlizApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAINenukbxgu9GNkMM6CIKdHxGM5Zqfb0E',
    appId: '1:156415235765:ios:2e26b6a7a0a7759282d0fc',
    messagingSenderId: '156415235765',
    projectId: 'dhlizapp',
    storageBucket: 'dhlizapp.appspot.com',
    androidClientId: '156415235765-2ga5u9mjf4sch8ttf37h2cboueoc3d2e.apps.googleusercontent.com',
    iosClientId: '156415235765-jsjlq93gujs2dcbk99jj0imlr9kmmoq5.apps.googleusercontent.com',
    iosBundleId: 'com.fuais.dhlizApp.RunnerTests',
  );
}
