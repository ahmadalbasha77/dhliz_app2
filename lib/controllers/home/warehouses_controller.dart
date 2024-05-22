import 'dart:developer';

import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:dhliz_app/models/home/warehouses_model.dart';
import 'package:get/get.dart';
import '../../network/reset_api.dart';

class WarehousesController extends GetxController {
  static WarehousesController get to => Get.isRegistered<WarehousesController>()
      ? Get.find<WarehousesController>()
      : Get.put(WarehousesController());

  WarehousesModel? warehousesModel;

  bool isNotVisible = true;

  @override
  void onInit() {
    super.onInit();
    getWarehouses();
  }

  Future<void> getWarehouses() async {
    try {
      log(sharedPrefsClient.customerId.toString());
      warehousesModel = await RestApi.getWarehouse();
      update();
    } catch (e) {
      // Handle errors or exceptions here
      throw Exception('Failed to fetch subscription data: $e');
    }
  }
}
