
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../view/main/home_screen.dart';
import '../view/main/profile/profile_screen.dart';
import '../view/main/transaction_screen.dart';

class MainController extends GetxController {
  static MainController get to => Get.isRegistered<MainController>()
      ? Get.find<MainController>()
      : Get.put(MainController());

  final selectedIndex = 0.obs;

  final tabs = [
    const HomeScreen(),
    const TransactionScreen(),
    // const NotificationScreen(),
    const ProfileScreen(),
  ];
}
