import 'package:dhliz_app/controllers/auth/sign_up_contoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompleteSignupScreen extends StatefulWidget {
  final String email;
  final String password;

  const CompleteSignupScreen(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<CompleteSignupScreen> createState() => _CompleteSignupScreenState();
}

class _CompleteSignupScreenState extends State<CompleteSignupScreen> {
  final _controller = RegisterController.to;
  bool loading = false;

  @override
  void initState() {
    _controller.email.text = widget.email;
    _controller.password.text = widget.password;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: _controller.keyForm,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Image.asset(
                  "image/home/Artboard 17.png",
                  width: 160.w,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: Text(
                    "Complete your information".tr,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextFormField(
                  controller: _controller.fullName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your name'.tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * .027,
                          horizontal: screenSize.width * .03),
                      hintStyle: const TextStyle(
                        color: Colors.black38,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 242, 238, 1),
                      labelText: "Full Name".tr,
                      labelStyle: const TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _controller.businessName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter business name'.tr;
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * .027,
                          horizontal: screenSize.width * .02),
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 242, 238, 1),
                      labelText: "Business Name".tr,
                      labelStyle: const TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _controller.businessCompetence,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter business competence'.tr;
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * .027,
                          horizontal: screenSize.width * .03),
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 242, 238, 1),
                      labelText: "Business Competence".tr,
                      labelStyle: const TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _controller.phoneNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter phone number'.tr;
                    }
                    if (value.length > 10 || value.length < 10) {
                      return 'Enter a correct number'.tr;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * .027,
                          horizontal: screenSize.width * .03),
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 242, 238, 1),
                      labelText: "Phone Number".tr,
                      labelStyle: const TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: _controller.phoneNumber2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter phone number 2'.tr;
                    }
                    if (value.length > 10 || value.length < 10) {
                      return 'Enter a correct number'.tr;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * .027,
                          horizontal: screenSize.width * .03),
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 242, 238, 1),
                      labelText: "Phone Number 2".tr,
                      labelStyle: const TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 25.h,
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
                    onPressed: () async {
                      _controller.register();
                    },
                    child: loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Complete".tr,
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
      ),
    );
  }
}
