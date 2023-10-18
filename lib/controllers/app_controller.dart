

import 'package:get/get.dart';

import '../config/shared_prefs_client.dart';

class AppController extends GetxController {
  static AppController get to => Get.isRegistered<AppController>() ? Get.find<AppController>() : Get.put(AppController());

  init() {



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
