import 'dart:convert';
import 'dart:developer';
import 'package:dhliz_app/network/reset_api.dart';
import 'package:dhliz_app/policy_screen.dart';
import 'package:dhliz_app/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/shared_prefs_client.dart';
import '../../config/utils.dart';
import '../../models/auth/login_model.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.isRegistered<LoginController>()
      ? Get.find<LoginController>()
      : Get.put(LoginController());

  final keyForm = GlobalKey<FormState>();

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  bool isNotVisible = true;


  UserResponse? userResponse;

  signIn() async {
    if (keyForm.currentState!.validate()) {
      Utils.showLoadingDialog();
      log(controllerUsername.text);
      log(controllerPassword.text);
      userResponse = await RestApi.login(jsonEncode({
        'emailOrUsername': controllerUsername.text,
        'password': controllerPassword.text
      }));

      if (userResponse!.isSuccess == true) {
        var response = userResponse!.response;
        sharedPrefsClient.accessToken = response.token;
        sharedPrefsClient.email = controllerUsername.text;
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
