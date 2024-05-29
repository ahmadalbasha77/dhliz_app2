import 'dart:io';

import 'package:dhliz_app/models/home/stock_model.dart';
import 'package:dhliz_app/network/reset_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/shared_prefs_client.dart';
import '../../config/utils.dart';
import '../../models/home/add_stock_model.dart';
import '../../view/home/self mangement of invntory/enter/Inventory_details.dart';
import '../../view/new home/enter inventory/add stock/add_enter_stcok_screen.dart';
import '../../view/new home/enter inventory/enter_inventory_screen.dart';

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
    print(subscriptionId.toString());
    Utils.showLoadingDialog();

    Map<String, String> fields = {
      'Stock.Name': controllerName.text,
      'Stock.Code': controllerCode.text,
      'Stock.Brand': controllerBrand.text,
      'Stock.UPC': controllerUpc.text,
      'Stock.Description': controllerDescription.text,
      'Stock.Photo': ' ',
      'Stock.Capacity': '0',
      'Stock.Temperature.High': checkListItems[0]['value'].toString(),
      'Stock.Temperature.Cold': checkListItems[1]['value'].toString(),
      'Stock.Temperature.Freezing': checkListItems[2]['value'].toString(),
      'Stock.Temperature.Dry': 'false',
      'Stock.Temperature.Id': '1',
      'Stock.MaterialType.Id': '1',
      'Stock.SubscriptionId': subscriptionId.toString(),
    };

    try {
      AddStockModel? addStockModel = await RestApi.addStock(
        fields: fields,
        filePath: image?.path ?? '', // Ensure image path is not null
      );

      if (addStockModel != null) {
        AddStockDataModel addStockDataModel = addStockModel.response;
        print(addStockModel.response);
        Get.off(() => AddEnterInventoryScreen(data: addStockDataModel));
        print('Stock created successfully');
      } else {
        print('Failed to create stock: response is null');
      }
    } catch (e) {
      // Handle exceptions
      print('Error creating stock: $e');
    } finally {
      Utils.hideLoadingDialog();
    }
  }
}
