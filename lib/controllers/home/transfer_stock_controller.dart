import 'dart:convert';

import 'package:dhliz_app/network/reset_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class TransferStockController extends GetxController {
  static TransferStockController get to => Get.isRegistered<TransferStockController>()
      ? Get.find<TransferStockController>()
      : Get.put(TransferStockController());

  TextEditingController space = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController fromStockId = TextEditingController();
  TextEditingController toStockId = TextEditingController();
  var selected;

  Future<void> transferStock(BuildContext context) async {
    bool result = await RestApi.createTransaction(jsonEncode({
      "id": 0,
      "quantity": space.text,
      "actionType": 2,
      "status": 0,
      "fromStockId": fromStockId.text,
      "toStockId": selected,
      "rejectReason": "string"
    }));
    if (result == true) {
      Get.back();
      Get.back();
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text:
          'A new entry transaction request has been sent. Please wait for approval',
          showConfirmBtn: true,
          confirmBtnColor: Colors.white,
          confirmBtnTextStyle: const TextStyle(color: Colors.black),
          title: 'Completed Successfully!',
          textAlignment: TextAlign.center);
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'The subscription space is smaller than the required space',
          showConfirmBtn: true,
          confirmBtnColor: Colors.white,
          confirmBtnTextStyle: const TextStyle(color: Colors.black),
          title: 'Error!',
          textAlignment: TextAlign.center);
    }
  }
}
