import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'complete_signup_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isNotVisible = true;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Image.asset(
                  "image/home/Artboard 16.png",
                  width: 160.w,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    "Sign Up".tr,
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Enter your data to register in our warehouse".tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter email'.tr;
                    }

                    return null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * .027,
                          horizontal: screenSize.width * .03),
                      hintStyle: const TextStyle(
                        color: Colors.black38,
                      ),
                      hintText: 'example@example.com',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 242, 238, 1),
                      labelText: "email".tr,
                      labelStyle: const TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter password'.tr;
                    }
                    if (value.length < 8) {
                      return 'Please use at least 8 characters'.tr;
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black87),
                  controller: password,
                  obscureText: isNotVisible,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        style: const ButtonStyle(
                            shadowColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          setState(() {
                            isNotVisible = !isNotVisible;
                          });
                        },
                        icon: Icon(
                          isNotVisible
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill,
                          color: Colors.black45,
                          size: 22,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * .027,
                          horizontal: screenSize.width * .03),
                      hintStyle: const TextStyle(color: Colors.black),
                      hintText: '**** ****',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 242, 238, 1),
                      labelText: "password".tr,
                      labelStyle: const TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 70.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have any account?  ".tr,
                      style: TextStyle(color: Colors.black45, fontSize: 13.sp),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Login'.tr,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.013,
                ),
                SizedBox(
                  width: double.infinity,
                  height: screenSize.height * 0.079,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(80, 46, 144, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Get.to(() => CompleteSignupScreen(
                              email: email.text,
                              password: password.text,
                            ));
                      }
                    },
                    child: Text(
                      "Sign Up".tr,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
