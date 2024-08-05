import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: screenSize.height * 0.05,
          ),
          Image.asset(
            "image/home/Artboard 14.png",
            width: screenSize.width * 0.8,
            height: screenSize.height * 0.2,
          ),
          SizedBox(
            height: screenSize.height * 0.19,
          ),
          Image.asset(
            "image/dhlez_logo.png",
            width: screenSize.width * 0.45,
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          SizedBox(
            width: screenSize.width * 0.71,
            child: Text(
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
          ),
          SizedBox(
            height: screenSize.height * 0.13,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: screenSize.width * 0.085),
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
                Get.off(() =>  const LoginScreen());
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
    );
  }
}
