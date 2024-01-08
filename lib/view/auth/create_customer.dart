import 'dart:convert';
import 'package:dhliz_app/view/main/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../network/api_url.dart';
import '../main_screen.dart';

class SharedPrefsHelper {
  static Future<void> saveLoginState(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', isLogin);
  }
}

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({Key? key}) : super(key: key);

  @override
  _CreateCustomerScreenState createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  bool isCustomerCreated = false;

  void postData() async {
    final String apiUrl = '${ApiUrl.API_BASE_URL}/Customer/Create';

    Map<String, dynamic> requestBody = {
      "businessName": businessNameController.text,
      "businessCompetence": businessCompetenceController.text,
      "info": {
        "name": nameController.text,
        "phone": phoneController.text,
        "phone2": phone2Controller.text,
        "documents": [
          {
            "name": 'documentNameController',
            "file": 'documentFileController',
          }
        ],
        "address": {
          "city": cityController.text,
          "state": stateController.text,
          "street": streetController.text,
          "lat": '2.0',
          "lot": '25.5'
        }
      }
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("POST request successful!");
      print("Response: ${response.body}");

      // Parse the JSON response
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Check if "response" array is not empty
      if (jsonResponse['response'] != null &&
          jsonResponse['response'].isNotEmpty) {
        // Extract the "id" from the first item in the "response" array
        int postId = jsonResponse['response'][0]['id'];

        // Save the "id" to SharedPreferences
        saveIdToSharedPreferences(postId);

        // Save login state (assuming the user is logged in after creating a customer)
        SharedPrefsHelper.saveLoginState(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
        // Now you can use the postId variable as needed.
      }
    } else {
      print("Failed to make POST request. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  }

  Future<void> saveIdToSharedPreferences(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('postId', id);
    print("Saved Post ID to SharedPreferences: $id");
  }

  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true); // Set the login state to true
    print("Saved Login State to SharedPreferences");
  }

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessCompetenceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lotController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter this field'.tr;
                    } else {}
                  },
                  controller: businessNameController,
                  decoration: InputDecoration(labelText: 'Business Name'.tr),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter this field'.tr;
                    } else {}
                  },
                  controller: businessCompetenceController,
                  decoration:
                      InputDecoration(labelText: 'Business Competence'.tr),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter this field'.tr;
                    } else {}
                  },
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'.tr),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter this field'.tr;
                    } else {}
                  },
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone'.tr),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter this field'.tr;
                    } else {}
                  },
                  controller: phone2Controller,
                  decoration: InputDecoration(labelText: 'Phone 2'.tr),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter this field'.tr;
                    } else {}
                  },
                  controller: cityController,
                  decoration: InputDecoration(labelText: 'City'.tr),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter this field'.tr;
                    } else {}
                  },
                  controller: stateController,
                  decoration: InputDecoration(labelText: 'State'.tr),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter this field'.tr;
                    } else {}
                  },
                  controller: streetController,
                  decoration: InputDecoration(labelText: 'Street'.tr),
                ),
                // TextField(
                //   controller: latController,
                //   decoration: InputDecoration(labelText: 'Latitude'),
                // ),
                // TextField(
                //   controller: lotController,
                //   decoration: InputDecoration(labelText: 'Longitude'),
                // ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 35, 37, 56),
                  )),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      postData();
                    }

                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
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
