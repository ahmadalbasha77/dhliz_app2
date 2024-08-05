import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:dhliz_app/view/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/sign_in_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = LoginController.to;

  @override
  void initState() {
    if (sharedPrefsClient.isLogin) {
      _controller.controllerUsername.text = sharedPrefsClient.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: _controller.keyForm,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.06,
              ),
              Image.asset(
                alignment: Alignment.center,
                "image/home/Artboard 15.png",
                width: screenSize.width * 0.49,
              ),
              SizedBox(
                height: screenSize.height * 0.08,
              ),
              Center(
                child: Text(
                  "Login".tr,
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
                  "Enter your email and password to access the warehouse".tr,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.039,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.06,
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * .07),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your Username'.tr;
                    }
                    return null;
                  },
                  controller: _controller.controllerUsername,
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
                      return 'Please enter your password'.tr;
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black87),
                  controller: _controller.controllerPassword,
                  obscureText: _controller.isNotVisible,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        style: const ButtonStyle(
                            shadowColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          setState(() {
                            _controller.isNotVisible =
                                !_controller.isNotVisible;
                          });
                        },
                        icon: Icon(
                          _controller.isNotVisible
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
                height: screenSize.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have Account ?  ".tr,
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: screenSize.width * .038),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignUpScreen());
                    },
                    child: Text(
                      'Sign Up'.tr,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: screenSize.width * .04),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                  onPressed: () async {
                    _controller.signIn();
                  },
                  child: Text(
                    "Login".tr,
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
