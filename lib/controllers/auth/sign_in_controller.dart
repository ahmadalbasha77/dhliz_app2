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

  // Future<UserResponse> authenticateUser(
  //     String emailOrUsername, String password) async {
  //   String url = 'https://api.dhlez.sa/Login';
  //   Map<String, String> headers = {"Content-type": "application/json"};
  //   String jsonBody =
  //       json.encode({"emailOrUsername": emailOrUsername, "password": password});
  //
  //   try {
  //     var response =
  //         await http.post(Uri.parse(url), headers: headers, body: jsonBody);
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       print(data);
  //
  //       print(response.body);
  //
  //       // UserResponse userResponse =
  //       // UserResponse.fromJson(json.decode(response.body));
  //
  //       if (json.decode(response.body)['isSuccess'] == true) {
  //         var responseData = json.decode(response.body)['response'][0];
  //         String token = responseData['token'];
  //         int userId = responseData['userId'];
  //         bool isActive = responseData['isActive'];
  //         String userName = responseData['username'];
  //         int customerId = responseData['customerId'];
  //         sharedPrefsClient.accessToken = token;
  //         sharedPrefsClient.fullName = userName;
  //         sharedPrefsClient.customerId = customerId;
  //
  //         // sharedPrefsClient.accessToken = data['response']['token'].toString();
  //         print('***********************************');
  //         print('Customer : ' + sharedPrefsClient.customerId.toString());
  //         print('***********************************');
  //         print('is active : ' + isActive.toString());
  //         print(response.body);
  //         print('988888888888888888888888');
  //
  //         print(userId);
  //         if (isActive == true) {
  //           Get.offAll(() => const MainScreen());
  //           sharedPrefsClient.isLogin = true;
  //           print('***************************');
  //         } else {
  //           Get.to(() => PolicyScreen(
  //                 userId: userId,
  //               ));
  //           print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
  //         }
  //       } else {
  //         print('aaaaaaaaaaaaaaaaaaaaaaa');
  //         // Utils.showSnackbar('Please try again'.tr, data['error'].toString());
  //       }
  //
  //       return UserResponse.fromJson(json.decode(response.body));
  //     } else if (response.statusCode == 400) {
  //       Utils.showSnackbar(
  //           'Please try again'.tr, 'Email or password is incorrect');
  //       throw Exception('Failed to authenticate user ${response.statusCode}');
  //     } else {
  //       Utils.showSnackbar(
  //           'Please try again'.tr, 'Check your internet connection');
  //       throw Exception('Failed to authenticate user ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }
  //
  // signIn() async {
  //   if (keyForm.currentState!.validate()) {
  //     Utils.showLoadingDialog();
  //     print('aaaaaaaaaaaaaaaaaaaaaaa');
  //     UserResponse userResponse = await authenticateUser(
  //         controllerUsername.text, controllerPassword.text);
  //   }
  // }

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
        sharedPrefsClient.fullName = response.username;
        sharedPrefsClient.customerId = response.customerId;
        print(response.userId);
        print(response.isActive);
        print('*************************');
        if (response.isActive == true) {
          Get.offAll(() => const MainScreen());
          sharedPrefsClient.isLogin = true;
        } else {
          Get.to(() => PolicyScreen(
                userId: response.userId,
              ));
        }
      }
    }
  }
}
