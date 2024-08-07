import 'dart:io';

import 'package:dhliz_app/network/reset_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/utils.dart';
import '../../models/home/add_stock_model.dart';
import '../../view/home/self mangement of invntory/enter/add stock/add_enter_stcok_screen.dart';

class AddStockController extends GetxController {
  static AddStockController get to => Get.isRegistered<AddStockController>()
      ? Get.find<AddStockController>()
      : Get.put(AddStockController());

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCapacity = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerBrand = TextEditingController();
  TextEditingController controllerUpc = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  String? subscriptionId;
  File? image;

  List checkListItems = [
    {
      "id": 1,
      "value": false,
      "title": "Dry".tr,
    },
    {
      "id": 2,
      "value": false,
      "title": "Cold".tr,
    },
    {
      "id": 3,
      "value": false,
      "title": "Freezing".tr,
    }
  ];
  bool isLoading = false;

  Future<void> addStock() async {
    Utils.showLoadingDialog();

    Map<String, String> fields = {
      'Name': controllerName.text,
      'Code': controllerCode.text,
      'Brand': controllerBrand.text,
      'UPC': controllerUpc.text,
      'Description': controllerDescription.text,
      'Photo': ' ',
      'Capacity': '0',
      // 'Stock.Temperature.High': checkListItems[0]['value'].toString(),
      // 'Stock.Temperature.Cold': checkListItems[1]['value'].toString(),
      // 'Stock.Temperature.Freezing': checkListItems[2]['value'].toString(),
      // 'Stock.Temperature.Dry': 'false',
      // 'Stock.Temperature.Id': '1',
      // 'Stock.MaterialType.Id': '1',
      'SubscriptionId': subscriptionId.toString(),
    };

    try {
      AddStockModel? addStockModel = await RestApi.addStock(
        fields: fields,
        filePath: image?.path ?? '', // Ensure image path is not null
      );

      AddStockDataModel addStockDataModel = addStockModel!.response;
      Get.off(() => AddEnterInventoryScreen(data: addStockDataModel));
    } catch (e) {
      // Handle exceptions
    } finally {
      Utils.hideLoadingDialog();
    }
  }
}
