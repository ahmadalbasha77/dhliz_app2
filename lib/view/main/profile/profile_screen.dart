import 'dart:convert';

import 'package:dhliz_app/view/main/profile/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/app_color.dart';
import '../../../config/shared_prefs_client.dart';
import '../../../network/api_url.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> data = [];

  Future<void> fetchData() async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // int? id = prefs.getInt('postId');
      // print(id);
      final response = await http.get(
          Uri.parse(
              '${ApiUrl.API_BASE_URL}/Customer/GetById?id=${sharedPrefsClient.customerId}'),
          headers: {
            'Authorization': 'Bearer ${sharedPrefsClient.accessToken}',
          });
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('response')) {
          final responseData = jsonResponse['response'];

          if (responseData.isNotEmpty) {
            setState(() {
              // Cast each element of responseData to Map<String, dynamic>
              data = (responseData as List)
                  .map((item) => Map<String, dynamic>.from(item))
                  .toList();
            });
          } else {
            print('Empty response array');
          }
        } else {
          print('Invalid response structure: Missing "response" key');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.1,
                            horizontal: screenWidth * 0.05,
                          ),
                          child: Text(
                            "Profile".tr,
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: AssetImage(
                                  'image/home/istockphoto-610003972-612x612-removebg-preview.png'),
                              radius: screenWidth * 0.17,
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenWidth * 0.025,
                          ),
                          child: Text(
                            sharedPrefsClient.fullName,
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Container(
                          width: screenWidth * 0.34,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColor.buttonColor),
                            ),
                            onPressed: () {
                              Get.to(SettingsScreen());
                            },
                            child: Text(
                              'Settings'.tr,
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      width: screenWidth * 0.9,
                      margin: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.04,
                        horizontal: screenWidth * 0.05,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: screenWidth * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: screenWidth * 0.025,
                                bottom: screenWidth * 0.04,
                                // right: screenWidth * 0.25,
                                // left: screenWidth * 0.15
                              ),
                              child: Text(
                                '${'Personal Information'.tr}   ',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.015,
                            ),
                            child: Text(
                              '${'Username'.tr} : ${data[0]['info']['name']}',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.015,
                            ),
                            child: Text(
                              '${'Email'.tr} : ${data[0]['info']['email']}',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.015,
                            ),
                            child: Text(
                              '${'phone'.tr} : ${data[0]['info']['phone']}',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.015,
                            ),
                            child: Text(
                              '${'Business Name'.tr} : ${data[0]['businessName']}',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.015,
                            ),
                            child: Text(
                              '${'Business Competence'.tr} : ${data[0]['businessCompetence']}',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //     horizontal: screenWidth * 0.05,
                          //     vertical: screenWidth * 0.015,
                          //   ),
                          //   child:
                          //   Text(
                          //     '${'Address'.tr} : ${data[0]['info']['address']['city']} , ${data[0]['info']['address']['street']}',
                          //     style: TextStyle(fontSize: screenWidth * 0.035),
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //     horizontal: screenWidth * 0.05,
                          //     vertical: screenWidth * 0.015,
                          //   ),
                          //   child: Text(
                          //     '${'Subscription Ends'.tr} : 20/10/2024',
                          //     style:
                          //         TextStyle(fontSize: screenWidth * 0.035),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
