import 'package:dhliz_app/controllers/main/profile_controller.dart';
import 'package:dhliz_app/view/main/profile/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_color.dart';
import '../../../config/shared_prefs_client.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = ProfileController.to;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        body: GetBuilder<ProfileController>(
          builder: (controller) => _controller.profileData == null
              ? const Center(child: CircularProgressIndicator())
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
                                  backgroundImage: const AssetImage(
                                      'image/home/profile.png'),
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
                            SizedBox(
                              width: screenWidth * 0.34,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColor.buttonColor),
                                ),
                                onPressed: () {
                                  Get.to(() => const SettingsScreen());
                                },
                                child: Text(
                                  'Settings'.tr,
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.04),
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
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.04),
                          ),
                          width: screenWidth * 0.9,
                          margin: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.04,
                            horizontal: screenWidth * 0.05,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: screenWidth * 0.03),
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
                                    style:
                                        TextStyle(fontSize: screenWidth * 0.04),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenWidth * 0.015,
                                ),
                                child: Text(
                                  '${'Username'.tr} : ${_controller.info!.name}',
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenWidth * 0.015,
                                ),
                                child: Text(
                                  '${'Email'.tr} : ${_controller.info!.email}',
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenWidth * 0.015,
                                ),
                                child: Text(
                                  '${'phone'.tr} : ${_controller.info!.phone}',
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenWidth * 0.015,
                                ),
                                child: Text(
                                  '${'Business Name'.tr} : ${_controller.profileData!.businessName}',
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenWidth * 0.015,
                                ),
                                child: Text(
                                  '${'Business Competence'.tr} : ${_controller.profileData!.businessCompetence}',
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
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
        ),
      ),
    );
  }
}
