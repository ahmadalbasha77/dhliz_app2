import 'dart:convert';

import 'package:dhliz_app/controllers/auth/sign_up_contoller.dart';
import 'package:dhliz_app/policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/shared_prefs_client.dart';
import '../../config/utils.dart';
import '../main_screen.dart';
import 'package:http/http.dart' as http;

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

  // void postData() async {
  //   Utils.showLoadingDialog();
  //
  //   // setState(() {
  //   //   loading = true;
  //   // });
  //
  //   var url = Uri.parse('https://b739-46-248-206-51.ngrok-free.app/Signup');
  //
  //   // Define the request body
  //   var body = jsonEncode({
  //     "businessName": businessName.text,
  //     "businessCompetence": businessCompetence.text,
  //     "info": {
  //       "name": fullName.text,
  //       "phone": phoneNumber.text,
  //       "password": widget.password,
  //       "email": widget.email,
  //       "phone2": phoneNumber2.text,
  //       // "documents": [
  //       //   {
  //       //     "id": 0,
  //       //     "createdDate": "2024-02-20T06:08:42.624Z",
  //       //     "name": "string",
  //       //     "file": "string",
  //       //     "filePath": "string"
  //       //   }
  //       // ],
  //       // "address": {
  //       //   "city": "string",
  //       //   "state": "string",
  //       //   "street": "string",
  //       //   "lat": "string",
  //       //   "lot": "string"
  //       // }
  //     },
  //     // "warehouseId": 0
  //   });
  //
  //   // Make the POST request
  //   var response = await http.post(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: body,
  //   );
  //   print(body);
  //   // Handle the response
  //   if (response.statusCode == 200) {
  //     if (json.decode(response.body)['isSuccess'] == true) {
  //       var responseData = json.decode(response.body)['response'][0];
  //       String token = responseData['token'];
  //       bool isActive = responseData['isActive'];
  //       int userId = responseData['userId'];
  //       String userName = responseData['username'];
  //       int customerId = responseData['customerId'];
  //
  //       sharedPrefsClient.accessToken = token;
  //       sharedPrefsClient.fullName = userName;
  //       sharedPrefsClient.customerId = customerId;
  //
  //       // sharedPrefsClient.accessToken = data['response']['token'].toString();
  //       print('***********************************');
  //       print('Customer : ' + sharedPrefsClient.customerId.toString());
  //
  //       print('***********************************');
  //       if (isActive == true) {
  //         sharedPrefsClient.isLogin = true;
  //         Get.offAll(() => MainScreen());
  //         sharedPrefsClient.isLogin = true;
  //         print('***************************');
  //       } else {
  //         Get.to(() => PolicyScreen(
  //               userId: userId,
  //             ));
  //         print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
  //       }
  //       setState(() {
  //         loading = false;
  //       });
  //       print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
  //       print("POST request successful");
  //       print("Response: ${response.body}");
  //     }
  //   } else if (response.statusCode == 400) {
  //     Utils.showSnackbar(
  //         'Please try again'.tr, 'The email already exists. Use another email');
  //   } else {
  //     Utils.showSnackbar(
  //         'Please try again'.tr, 'Check your internet connection');
  //     print("POST request failed with status: ${response.statusCode}");
  //   }
  // }
  //
  // TextEditingController fullName = TextEditingController();
  // TextEditingController businessName = TextEditingController();
  // TextEditingController businessCompetence = TextEditingController();
  // TextEditingController phoneNumber = TextEditingController();
  // TextEditingController phoneNumber2 = TextEditingController();
  //
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.email.text = widget.email;
    _controller.password.text = widget.password;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    // phoneNumber.text = '+966';
    // phoneNumber2.text = '+966';
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _controller.keyForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Image.asset(
                  "image/home/Artboard 17.png",
                  width: screenSize.width * 0.5,
                ),
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                Center(
                  child: Text(
                    "Complete your information".tr,
                    style: TextStyle(
                        fontSize: screenSize.width * 0.045,
                        color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .01),
                  child: TextFormField(
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
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "Full Name".tr,
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .07,
                    vertical: screenSize.height * .01,
                  ),
                  child: TextFormField(
                    controller: _controller.businessName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter business name'.tr;
                      } return null;
                    },
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .027,
                            horizontal: screenSize.width * .02),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "Business Name".tr,
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .01),
                  child: TextFormField(
                    controller: _controller.businessCompetence,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter business competence'.tr;
                      } return null;
                    },
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .027,
                            horizontal: screenSize.width * .03),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "Business Competence".tr,
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .01),
                  child: TextFormField(
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
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .027,
                            horizontal: screenSize.width * .03),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "Phone Number".tr,
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .01),
                  child: TextFormField(
                    controller: _controller.phoneNumber2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter phone number 2'.tr;
                      }
                      if (value.length > 10 || value.length < 10) {
                        return 'Enter a correct number'.tr;
                      } return null;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .027,
                            horizontal: screenSize.width * .03),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "Phone Number 2".tr,
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.015,
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(horizontal: screenSize.width * .1),
                  height: screenSize.height * 0.079,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(80, 46, 144, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {
                      _controller.register();
                    },
                    child: loading
                        ? CircularProgressIndicator(
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
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
