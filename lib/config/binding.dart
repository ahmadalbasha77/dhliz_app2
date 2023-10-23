import 'package:dhliz_app/controllers/app_controller.dart';
import 'package:dhliz_app/controllers/main/notification_controller.dart';
import 'package:get/get.dart';
import '../controllers/auth/sign_in_controller.dart';
import '../controllers/home/withdrawal_controller.dart';
import '../controllers/main/edit_profile_controller.dart';

class BindingQ extends Bindings{


  @override
  void dependencies (){

    Get.lazyPut(() => AppController());
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => WithdrawalController());
    Get.lazyPut(() => EditProfileController());
  }

}