import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhliz_app/view/main/profile/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../config/shared_prefs_client.dart';
import '../../../config/utils.dart';
import '../../../controllers/main/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = ProfileController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      body: GetBuilder<ProfileController>(
        builder: (controller) => Column(
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
                        "Profile",
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              Utils.isEmpty(sharedPrefsClient.image)
                                  ? null
                                  : CachedNetworkImageProvider(
                                      sharedPrefsClient.image),
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
                              MaterialStateProperty.all(Colors.black),
                        ),
                        onPressed: () {
                          Get.to(SettingsScreen());
                        },
                        child: Text(
                          'Settings',
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
                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.2,
                              vertical: screenWidth * 0.025,
                            ),
                            child: Text(
                              'Personal Information',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.015,
                            ),
                            child: Text(
                              'Username: ${sharedPrefsClient.fullName}',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.025,
                            ),
                            child: Text(
                              'Phone: 0795411633',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.015,
                            ),
                            child: Text(
                              'Email: ${_controller}',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.015,
                            ),
                            child: Text(
                              'Number of Warehouses: 2',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: screenWidth * 0.05,
                              bottom: screenWidth * 0.015,
                              top: screenWidth * 0.015,
                            ),
                            child: Text(
                              'Business Name: Mzmq Company',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: screenWidth * 0.05,
                              bottom: screenWidth * 0.01,
                              top: screenWidth * 0.015,
                            ),
                            child: Text(
                              'Subscription Ends: 20/10/2024',
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
