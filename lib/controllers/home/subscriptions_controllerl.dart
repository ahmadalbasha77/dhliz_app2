import 'dart:developer';

import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:get/get.dart';
import '../../models/home/subscriptions_model.dart';
import '../../network/reset_api.dart';

class SubscriptionsController extends GetxController {
  static SubscriptionsController get to =>
      Get.isRegistered<SubscriptionsController>()
          ? Get.find<SubscriptionsController>()
          : Get.put(SubscriptionsController());

  SubscriptionsModel? subscriptionsModel;
  SubscriptionsDataModel? subscriptionsDataModel;
  Warehouse? warehouse;
  Address? address;
  Price? price;
  Temperature? temperature;
  bool isNotVisible = true;

  // @override
  // void onInit() {
  //   super.onInit();
  //   getSubscriptions();
  // }

  Future<void> getSubscriptions() async {
    try {
      log(sharedPrefsClient.customerId.toString());
      subscriptionsModel = await RestApi.getSubscriptions();
      update();
    } catch (e) {
      // Handle errors or exceptions here
      throw Exception('Failed to fetch subscription data: $e');
    }
  }
}
