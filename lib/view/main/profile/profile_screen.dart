import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dhliz_app/controllers/main/profile_controller.dart';
import 'package:dhliz_app/view/main/profile/settings/settings_screen.dart';
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
    // Use MediaQuery to adapt to screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isTablet = screenWidth >= 600; // Arbitrary breakpoint for tablet

    double textScaleFactor = isTablet ? 1.2 : 1.2; // Scale text up for tablets

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        body: GetBuilder<ProfileController>(
          builder: (controller) => _controller.profileData == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfileHeader(screenWidth, textScaleFactor),
                      _buildProfileInformation(screenWidth, textScaleFactor),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(double screenWidth, double textScaleFactor) {
    return Row(
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
                  fontSize: screenWidth * 0.06 * textScaleFactor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: const AssetImage('image/home/profile.png'),
              radius: screenWidth * 0.13,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenWidth * 0.025,
              ),
              child: Text(
                sharedPrefsClient.fullName,
                style: TextStyle(
                  fontSize: screenWidth * 0.06 * textScaleFactor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.35,
              height: screenWidth * 0.08,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp))),
                  backgroundColor:
                      MaterialStateProperty.all(AppColor.buttonColor),
                ),
                onPressed: () {
                  Get.to(() => const SettingsScreen());
                },
                child: Text(
                  'Settings'.tr,
                  style: TextStyle(
                      fontSize: screenWidth * 0.038 * textScaleFactor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileInformation(double screenWidth, double textScaleFactor) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: screenWidth * 0.025,
                bottom: screenWidth * 0.04,
              ),
              child: Text(
                'Personal Information'.tr,
                style:
                    TextStyle(fontSize: screenWidth * 0.04 * textScaleFactor),
              ),
            ),
          ),
          _buildInfoText('Username'.tr, _controller.info!.name, screenWidth,
              textScaleFactor),
          _buildInfoText('email'.tr, _controller.info!.email, screenWidth,
              textScaleFactor),
          _buildInfoText('phone'.tr, _controller.info!.phone, screenWidth,
              textScaleFactor),
          _buildInfoText(
              'Business Name'.tr,
              _controller.profileData!.businessName,
              screenWidth,
              textScaleFactor),
          _buildInfoText(
              'Business Competence'.tr,
              _controller.profileData!.businessCompetence,
              screenWidth,
              textScaleFactor),
          // More text fields can be added similarly
        ],
      ),
    );
  }

  Widget _buildInfoText(
      String label, String value, double screenWidth, double textScaleFactor) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.015,
      ),
      child: Text(
        '$label : $value',
        style: TextStyle(fontSize: screenWidth * 0.030 * textScaleFactor),
      ),
    );
  }
}
