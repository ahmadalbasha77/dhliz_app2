import 'dart:convert';

import 'package:dhliz_app/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/shared_prefs_client.dart';
import '../main_screen.dart';
import 'package:http/http.dart' as http;

class CompleteSignupScreen extends StatefulWidget {
  String email;
  String password;

  CompleteSignupScreen({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<CompleteSignupScreen> createState() => _CompleteSignupScreenState();
}

class _CompleteSignupScreenState extends State<CompleteSignupScreen> {
  bool loading = false;

  void postData() async {
    setState(() {
      loading = true;
    });

    var url = Uri.parse('https://api.dhlez.sa/Signup');

    // Define the request body
    var body = jsonEncode({
      "businessName": businessName.text,
      "businessCompetence": businessCompetence.text,
      "info": {
        "name": fullName.text,
        "phone": phoneNumber.text,
        "password": widget.password,
        "email": widget.email,
        "phone2": phoneNumber2.text,
        // "documents": [
        //   {
        //     "id": 0,
        //     "createdDate": "2024-02-20T06:08:42.624Z",
        //     "name": "string",
        //     "file": "string",
        //     "filePath": "string"
        //   }
        // ],
        // "address": {
        //   "city": "string",
        //   "state": "string",
        //   "street": "string",
        //   "lat": "string",
        //   "lot": "string"
        // }
      },
      // "warehouseId": 0
    });

    // Make the POST request
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    // Handle the response
    if (response.statusCode == 200) {

      if (json.decode(response.body)['isSuccess'] == true) {
        setState(() {
          loading = false;
        });
        var responseData = json.decode(response.body)['response'][0];
        String token = responseData['token'];
        String userName = responseData['username'];
        int customerId = responseData['customerId'];
        sharedPrefsClient.isLogin = true;
        sharedPrefsClient.accessToken = token;
        sharedPrefsClient.fullName = userName;
        sharedPrefsClient.customerId = customerId;

        // sharedPrefsClient.accessToken = data['response']['token'].toString();
        print('***********************************');
        print('Customer : ' + sharedPrefsClient.customerId.toString());
        print('***********************************');
        Get.offAll(() => MainScreen());
        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
        print("POST request successful");
        print("Response: ${response.body}");
      } else {
        print("POST request failed with status: ${response.statusCode}");
      }
    }
  }
  TextEditingController fullName = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController businessCompetence = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneNumber2 = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    // phoneNumber.text = '+966';
    // phoneNumber2.text = '+966';
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
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
                    "Complete your information",
                    style: TextStyle(
                        fontSize: screenSize.width * 0.043,
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
                    controller: fullName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your name';
                      }
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
                        labelText: "Full Name",
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .07,
                    vertical: screenSize.height * .01,
                  ),
                  child: TextFormField(
                    controller: businessName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter business name';
                      }
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
                        labelText: "Business Name",
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .01),
                  child: TextFormField(
                    controller: businessCompetence,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter business competence';
                      }
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
                        labelText: "Business Competence",
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .01),
                  child: TextFormField(
                    controller: phoneNumber,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter phone number 2';
                      }
                      if (value.length > 10 || value.length < 10) {
                        return 'Enter a correct number';
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
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .01),
                  child: TextFormField(
                    controller: phoneNumber2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter phone number 2';
                      }
                      if (value!.length > 10 || value.length < 10) {
                        return 'Enter a correct number';
                      }
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
                        labelText: "Phone Number 2",
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
                      backgroundColor: Color.fromRGBO(38, 50, 56, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        postData();
                      } else {
                        print('Not valid');
                      }
                    },
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            "Complete",
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
