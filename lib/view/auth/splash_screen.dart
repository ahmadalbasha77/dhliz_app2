import 'dart:async';

import 'package:dhliz_app/view/auth/login_screen.dart';
import 'package:dhliz_app/view/main/home_screen.dart';
import 'package:dhliz_app/view/main_screen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/enum/user_role_enum.dart';
import '../../config/shared_prefs_client.dart';
import '../../controllers/app_controller.dart';
import 'create_customer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  static Future<bool> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogin') ?? false;
  }
   Future<bool> isLogin =  getLoginState();

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    isLogin = getLoginState();

    // Wait for the future to complete and then execute the logic
    await Future.delayed(const Duration(seconds: 2));
    print(await isLogin);
    // Now, you can check the value of isLogin
    if (await isLogin == true) {
      Get.offAll(() => const MainScreen());
    } else {
      Get.offAll(() => const MainScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('image/dehliz/logo_dhlez.png'),
      logoWidth: 100,
      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: Colors.black,
    );
  }
}
