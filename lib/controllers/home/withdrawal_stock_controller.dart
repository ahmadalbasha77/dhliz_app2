import 'dart:convert';

import 'package:dhliz_app/network/reset_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class WithdrawalStockController extends GetxController {
  static WithdrawalStockController get to => Get.isRegistered<WithdrawalStockController>()
      ? Get.find<WithdrawalStockController>()
      : Get.put(WithdrawalStockController());

  TextEditingController space = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController stockId = TextEditingController();

  Future<void> withdrawalStock(BuildContext context) async {
    bool result = await RestApi.createTransaction(jsonEncode({
      "id": 0,
      "quantity": space.text,
      "actionType": 0,
      "status": 0,
      "fromStockId": stockId.text,
      "toStockId": stockId.text,
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
