import 'dart:async';

import 'package:dhliz_app/view/auth/login_screen.dart';
import 'package:dhliz_app/view/main_screen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/enum/user_role_enum.dart';
import '../../config/shared_prefs_client.dart';
import '../../controllers/app_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppController _controllerApp = AppController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (sharedPrefsClient.isLogin) {
        if (sharedPrefsClient.userRole == UserRoleEnum.user) {
          Get.offAll(() => const MainScreen());
        } else if (sharedPrefsClient.userRole == UserRoleEnum.admin) {
          Get.offAll(() => const MainScreen());
        }
      } else {
        Get.offAll(() => const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('image/home/Artboard 10.png'),
      logoWidth: 100,
      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: Colors.black,
    );
  }
}
