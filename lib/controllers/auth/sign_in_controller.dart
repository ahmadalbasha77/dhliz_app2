import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../config/shared_prefs_client.dart';
import '../../config/utils.dart';
import '../../models/auth/login_model.dart';
import '../../view/main/home_screen.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.isRegistered<SignInController>()
      ? Get.find<SignInController>()
      : Get.put(SignInController());

  final keyForm = GlobalKey<FormState>();

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  Future<UserResponse> authenticateUser(
      String emailOrUsername, String password) async {
    String url = 'https://c0ed-176-29-242-143.ngrok-free.app/Login';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody =
        json.encode({"emailOrUsername": emailOrUsername, "password": password});

    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        print(response.body);
        sharedPrefsClient.isLogin = true;
        sharedPrefsClient.accessToken = json.decode(response.body)['token'];
        print('************************************');
        print(sharedPrefsClient.accessToken);
        print('************************************');
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
      try {
        UserResponse userResponse = await authenticateUser(
            controllerUsername.text, controllerPassword.text);
        print(userResponse);
        // Handle user response as needed
      } catch (e) {
        // Handle authentication error
      } finally {
        Utils.showLoadingDialog();
        Get.off(() => HomeScreen());
      }
    }
  }
}
