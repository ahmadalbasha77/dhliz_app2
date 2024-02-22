import 'dart:convert';
import 'package:dhliz_app/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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


  Future<UserResponse> authenticateUser(
      String emailOrUsername, String password) async {
    String url = 'https://api.dhlez.sa/Login';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody =
        json.encode({"emailOrUsername": emailOrUsername, "password": password});

    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);

        print(response.body);

        // UserResponse userResponse =
        // UserResponse.fromJson(json.decode(response.body));

        if (json.decode(response.body)['isSuccess'] == true) {
          var responseData = json.decode(response.body)['response'][0];
          String token = responseData['token'];
          String userName = responseData['username'];
          int customerId = responseData['customerId'];
          sharedPrefsClient.isLogin = true;
          sharedPrefsClient.accessToken = token;
          sharedPrefsClient.fullName = userName;
          sharedPrefsClient.customerId = customerId;

          // sharedPrefsClient.accessToken = data['response']['token'].toString();
          print('***********************************');
          print('Customer : ' + sharedPrefsClient.customerId.toString());

          print('***********************************');
          Get.offAll(() => MainScreen());
          print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
        } else {
          print('aaaaaaaaaaaaaaaaaaaaaaa');
          Utils.showSnackbar('Please try again'.tr, data['error'].toString());
        }

        return UserResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to authenticate user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  signIn() async {
    if (keyForm.currentState!.validate()) {
      Utils.showLoadingDialog();
      print('aaaaaaaaaaaaaaaaaaaaaaa');
      try {
        UserResponse userResponse = await authenticateUser(
            controllerUsername.text, controllerPassword.text);
      } catch (e) {
        // Handle authentication error
      }
    }
  }
}
