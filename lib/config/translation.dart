import 'package:dhliz_app/config/ar.dart';
import 'package:dhliz_app/config/en.dart';
import 'package:get/get.dart';

class Translation extends Translations {

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en' : en,
    'ar' : ar,
  };

}