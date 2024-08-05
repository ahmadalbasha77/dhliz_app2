import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.06,
              ),
              Image.asset(
                "image/home/Artboard 16.png",
                width: screenSize.width * 0.49,
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Center(
                child: Text(
                  "Sign Up".tr,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.07,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.025,
              ),
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  "Enter your data to register in our warehouse".tr,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.042,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.075,
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .07),
                child: TextFormField(
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
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .07,
                    vertical: screenSize.height * .02),
                child: TextFormField(
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
              ),
              SizedBox(
                height: screenSize.height * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have any account?  ".tr,
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: screenSize.width * .038),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      'Login'.tr,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: screenSize.width * .04),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.013,
              ),
              Container(
                width: double.infinity,
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .1),
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenSize.width * .05),
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
