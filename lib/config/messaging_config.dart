import 'dart:developer';
import 'dart:io';

import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagingConfig {
  static String clickAction = '';
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static init() async {
    if (Platform.isAndroid) {
      sharedPrefsClient.isGMS = true;
    } else {
      sharedPrefsClient.isGMS = true;
    }
    log('isGMS : ${sharedPrefsClient.isGMS}');
    if (sharedPrefsClient.isGMS) {
      await FirebaseMessagingConfig.init();
    } else {
     // await HuaweiMessagingConfig.init();
    }
    log('Device token : ${sharedPrefsClient.deviceToken}');
  }
}

class FirebaseMessagingConfig {
  static init() async {
    await FirebaseMessaging.instance.requestPermission();
    sharedPrefsClient.deviceToken = await FirebaseMessaging.instance.getToken() ?? '';
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      FlutterAppBadger.removeBadge();
    }
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await MessagingConfig.flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(MessagingConfig.channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    var initialNotification = await FirebaseMessaging.instance.getInitialMessage();
    if (initialNotification != null) {

    }
  }

  static onMessage() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        MessagingConfig.flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              MessagingConfig.channel.id,
              MessagingConfig.channel.name,
              channelDescription: MessagingConfig.channel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    // await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
    // print('Handling a background message ${message.messageId}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      // MessagingConfig.flutterLocalNotificationsPlugin.show(
      //   notification.hashCode,
      //   notification.title,
      //   notification.body,
      //   NotificationDetails(
      //     android: AndroidNotificationDetails(
      //       MessagingConfig.channel.id,
      //       MessagingConfig.channel.name,
      //       channelDescription: MessagingConfig.channel.description,
      //
      //       //      one that already exists in example app.
      //       icon: '@mipmap/ic_launcher',
      //     ),
      //   ),
      // );
    }
    return;
  }
}

// class HuaweiMessagingConfig {
//   static init() async {
//     await hms_push.Push.setAutoInitEnabled(true);
//     hms_push.Push.getToken('');
//     hms_push.Push.getTokenStream.listen(
//       (event) {
//         sharedPrefsClient.deviceToken = event;
//       },
//       onError: (value) {
//         log('Device token1 : ${value.toString()}');
//       },
//     );
//     if (await FlutterAppBadger.isAppBadgeSupported()) {
//       FlutterAppBadger.removeBadge();
//     }
//     await hms_push.Push.registerBackgroundMessageHandler(hmsMessagingBackgroundHandler);
//   }
//
//   static onMessage() {
//     hms_push.Push.onMessageReceivedStream.listen(onMessageReceived, onError: onMessageReceiveError);
//     hms_push.Push.onNotificationOpenedApp.listen(_onNotificationOpenedApp);
//   }
//
//   static void _onNotificationOpenedApp(dynamic initialNotification) async {
//     // if (initialNotification != null) {
//     //   log('_onNotificationOpenedApp : $initialNotification');
//     //   MessagingConfig.clickAction = initialNotification['remoteMessage']?['data']?['click_action'] ?? '';
//     //   if (sharedPrefsClient.accessToken.isNotEmpty) {
//     //     CustomNavigator.clickActionNotification();
//     //   }
//     // }
//   }
//
//   static void onMessageReceived(hms_push.RemoteMessage remoteMessage) {
//     var notification = remoteMessage.notification;
//     if (notification != null) {
//       MessagingConfig.flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             MessagingConfig.channel.id,
//             MessagingConfig.channel.name,
//             channelDescription: MessagingConfig.channel.description,
//             icon: '@mipmap/ic_launcher',
//           ),
//         ),
//       );
//     }
//   }
//
//   static void onMessageReceiveError(Object error) {}
//
//   static Future<void> hmsMessagingBackgroundHandler(hms_push.RemoteMessage message) async {
//     var notification = message.notification;
//     if (notification != null) {
//       MessagingConfig.flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             MessagingConfig.channel.id,
//             MessagingConfig.channel.name,
//             channelDescription: MessagingConfig.channel.description,
//             //      one that already exists in example app.
//             icon: '@mipmap/ic_launcher',
//           ),
//         ),
//       );
//     }
//   }
// }
