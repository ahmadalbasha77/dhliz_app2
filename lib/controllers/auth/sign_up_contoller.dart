import 'dart:convert';
import 'dart:developer';
import 'package:dhliz_app/models/auth/register_model.dart';
import 'package:dhliz_app/network/reset_api.dart';
import 'package:dhliz_app/policy_screen.dart';
import 'package:dhliz_app/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/shared_prefs_client.dart';
import '../../config/utils.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.isRegistered<RegisterController>()
      ? Get.find<RegisterController>()
      : Get.put(RegisterController());

  final keyForm = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController businessCompetence = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneNumber2 = TextEditingController();

  bool isNotVisible = true;

  RegisterModel? registerModel;

  register() async {
    if (keyForm.currentState!.validate()) {
      log(email.text);
      log(password.text);
      Utils.showLoadingDialog();
      log(fullName.text);
      log(businessName.text);
      registerModel = await RestApi.register(jsonEncode({
        "businessName": businessName.text,
        "businessCompetence": businessCompetence.text,
        "info": {
          "name": fullName.text,
          "phone": phoneNumber.text,
          "password": password.text,
          "email": email.text,
          "phone2": phoneNumber2.text,
        },
      }));

      if (registerModel!.isSuccess == true) {
        print(registerModel!.response.email);
        var response = registerModel!.response;
        sharedPrefsClient.accessToken = response.token;
        sharedPrefsClient.fullName = response.username;
        sharedPrefsClient.customerId = response.customerId;
        if (response.isActive == true) {
          Utils.hideLoadingDialog();
          Get.offAll(() => const MainScreen());
          sharedPrefsClient.isLogin = true;
        } else {
          Utils.hideLoadingDialog();
          Get.to(() => PolicyScreen(
                userId: response.userId,
              ));
        }
      }
    }
  }
}
