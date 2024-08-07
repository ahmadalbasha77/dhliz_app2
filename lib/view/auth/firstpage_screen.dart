import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class FirstPageScreen extends StatefulWidget {
  const FirstPageScreen({super.key});

  @override
  State<FirstPageScreen> createState() => _FirstPageScreenState();
}

class _FirstPageScreenState extends State<FirstPageScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Image.asset(
                "image/home/Artboard 14.png",
                width: 250.w,
                // height: screenSize.height * 0.2,
              ),
              SizedBox(
                height: 120.h,
              ),
              Image.asset(
                "image/dhlez_logo.png",
                width: 180.w,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Dhlez Warehouse Management System is a specialized system designed to simplify and improve warehouse operations and manage them efficiently"
                    .tr,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'ar1'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 80.h,
              ),
              SizedBox(
                width: double.infinity,
                height: screenSize.height * 0.084,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(80, 46, 144, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: () {
                    sharedPrefsClient.isOpen = true;
                    Get.off(() => const LoginScreen());
                  },
                  child: const Text(
                    "GET STARTED",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
