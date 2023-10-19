

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../config/constant.dart';
import '../config/shared_prefs_client.dart';

class AppController extends GetxController {
  static AppController get to => Get.isRegistered<AppController>() ? Get.find<AppController>() : Get.put(AppController());

  init() {
    /// Version
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
    });

    ///Platform
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (sharedPrefsClient.isGMS) {
        platform = "android";
      } else {
        platform = "huawei";
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      platform = "ios";
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      platform = "windows";
    } else if (defaultTargetPlatform == TargetPlatform.fuchsia) {
      platform = "fuchsia";
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      platform = "macos";
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      platform = "linux";
    } else {
      platform = "web";
    }

    /// Language
    if (sharedPrefsClient.language == "") {
      if (Get.deviceLocale == null) {
        sharedPrefsClient.language = 'ar';
      } else {
        String language = Get.deviceLocale!.languageCode;
        if (language != 'en' && language != 'ar') {
          sharedPrefsClient.language = 'ar';
        } else {
          sharedPrefsClient.language = language;
        }
      }
    }
  }
}
