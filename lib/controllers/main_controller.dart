import 'package:get/get.dart';

import '../view/main/home_screen.dart';
import '../view/main/profile/profile_screen.dart';
import '../view/main/transaction/tansaction_page.dart';

class MainController extends GetxController {
  static MainController get to => Get.isRegistered<MainController>()
      ? Get.find<MainController>()
      : Get.put(MainController());

  final selectedIndex = 0.obs;

  final tabs = [
    const HomeScreen(),
    const TransactionPage(),
    // const EntryRequestsScreen(),
    // const NotificationScreen(),
    const ProfileScreen(),
  ];
}
