import 'dart:convert';
import 'package:dhliz_app/view/main/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../network/api_url.dart';

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
          "lat": latController.text,
          "lot": lotController.text
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Entry Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: businessNameController,
                decoration: InputDecoration(labelText: 'Business Name'),
              ),
              TextField(
                controller: businessCompetenceController,
                decoration: InputDecoration(labelText: 'Business Competence'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: phone2Controller,
                decoration: InputDecoration(labelText: 'Phone 2'),
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: stateController,
                decoration: InputDecoration(labelText: 'State'),
              ),
              TextField(
                controller: streetController,
                decoration: InputDecoration(labelText: 'Street'),
              ),
              TextField(
                controller: latController,
                decoration: InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: lotController,
                decoration: InputDecoration(labelText: 'Longitude'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  postData();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
