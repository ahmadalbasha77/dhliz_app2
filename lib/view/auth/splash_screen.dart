import 'dart:async';

import 'package:dhliz_app/view/auth/firstpage_screen.dart';
import 'package:dhliz_app/view/auth/login_screen.dart';
import 'package:dhliz_app/view/main_screen.dart';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/shared_prefs_client.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!sharedPrefsClient.isOpen) {
        Get.off(() => const FirstPageScreen());
      } else {
        if (sharedPrefsClient.isLogin) {
          Get.offAll(() => const MainScreen());
        } else {
          Get.offAll(() => const LoginScreen());
        }
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
      loaderColor: const Color.fromRGBO(80, 46, 144, 1.0),
    );
  }
}
