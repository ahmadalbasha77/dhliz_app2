import 'dart:async';

import 'package:dhliz_app/config/utils.dart';
import 'package:dhliz_app/view/auth/firstpage_screen.dart';
import 'package:dhliz_app/view/auth/login_screen.dart';
import 'package:dhliz_app/view/main_screen.dart';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/shared_prefs_client.dart';
import 'package:local_auth/local_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> _authenticate() async {
    final bool canCheckBiometrics = await auth.canCheckBiometrics;
    final bool isDeviceSupported = await auth.isDeviceSupported();
    print('Can check biometrics: $canCheckBiometrics');
    print('Is device supported: $isDeviceSupported');

    if (isDeviceSupported) {
      try {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to access this feature',
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
        );
        print('Did authenticate: $didAuthenticate');
        if (didAuthenticate) {
          print('Authentication succeeded');
          Utils.showLoadingDialog();
          Future.delayed(const Duration(seconds: 2), () async {
            Get.offAll(() => const MainScreen());
          });
        } else {
          print('Authentication failed');

        }
        return didAuthenticate; // Return the result of the authentication
      } catch (e) {
        // Handle error
        print('Error: $e');

      }
    } else {
      print('Biometrics not available or not set up.');

    }
    return false; // Return false if biometrics are not available or authentication fails
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      if (!sharedPrefsClient.isOpen) {
        Get.off(() => const FirstPageScreen());
      } else {
        if (sharedPrefsClient.isLogin) {
          Get.offAll(() => LoginScreen());
          await _authenticate();
        } else {
          Get.offAll(() => LoginScreen());
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
