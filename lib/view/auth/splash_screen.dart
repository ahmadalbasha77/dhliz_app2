import 'dart:async';

import 'package:dhliz_app/view/auth/login_screen.dart';
import 'package:dhliz_app/view/main/home_screen.dart';
import 'package:dhliz_app/view/main_screen.dart';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/shared_prefs_client.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (sharedPrefsClient.isLogin) {
        Get.offAll(() => MainScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('image/home/dhlez_app_logo_without_bg.png'),
      logoWidth: 100,
      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: Color.fromRGBO(80, 46, 144, 1.0),
    );
  }
}
