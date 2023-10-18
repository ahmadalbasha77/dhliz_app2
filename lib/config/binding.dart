import 'package:dhliz_app/controllers/app_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BindingQ extends Bindings{


  @override
  void dependencies (){

    Get.lazyPut(() => AppController());


  }

}