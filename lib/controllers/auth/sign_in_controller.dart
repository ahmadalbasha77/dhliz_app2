
import 'package:dhliz_app/view/auth/signup_screen.dart';
import 'package:dhliz_app/view/main/home_screen.dart';
import 'package:dhliz_app/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/enum/user_role_enum.dart';
import '../../config/shared_prefs_client.dart';
import '../../config/utils.dart';
import '../../network/reset_api.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.isRegistered<SignInController>() ? Get.find<SignInController>() : Get.put(SignInController());

  final keyForm = GlobalKey<FormState>();
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  signIn() async {
    if (keyForm.currentState!.validate()) {
      Utils.showLoadingDialog();
      var result = await RestApi.signIn(username: controllerUsername.text, password: controllerPassword.text);
      if (result.code == 200) {

        sharedPrefsClient.isLogin = true;
        sharedPrefsClient.accessToken = result.result.first.accessToken;
        sharedPrefsClient.applicationId = result.result.first.applicationId;
        sharedPrefsClient.fullName = result.result.first.fullName;
        sharedPrefsClient.image = result.result.first.image;
        sharedPrefsClient.userRole = UserRoleEnum.values.firstWhereOrNull((element) => element.name.toLowerCase() == result.result.first.role.toLowerCase()) ?? UserRoleEnum.unknown;
        if (sharedPrefsClient.userRole == UserRoleEnum.user) {

          Get.offAll(() => const MainScreen());
        } else  if (sharedPrefsClient.userRole == UserRoleEnum.admin) {
          Get.offAll(() => const MainScreen());
        }
      } else {
        Utils.showSnackbar('Please try again'.tr, result.message);
      }
    }
  }

  register() {
    Get.to(() => const SignUpScreen());
  }

  forgetPassword() {
    Get.to(() => const SignUpScreen());
  }
}
