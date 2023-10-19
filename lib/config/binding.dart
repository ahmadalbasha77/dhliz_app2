import 'package:dhliz_app/controllers/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controllers/auth/sign_in_controller.dart';

class BindingQ extends Bindings{


  @override
  void dependencies (){

    Get.lazyPut(() => AppController());
    Get.lazyPut(() => SignInController());

  }

}