import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dhliz_app/controllers/main/profile_controller.dart';
import 'package:dhliz_app/view/main/profile/settings/settings_screen.dart';
import '../../../config/app_color.dart';
import '../../../config/shared_prefs_client.dart';
import '../../../config/utils.dart';
import '../../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = ProfileController.to;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 231, 231, 231),
          actions: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: IconButton(
                  onPressed: () async {
                    if (await Utils.showAreYouSureDialog(
                        title: 'Sign Out'.tr)) {
                      sharedPrefsClient.clearProfile();
                      Get.deleteAll();
                      Get.offAll(() => const LoginScreen());
                    }
                  },
                  icon: const Icon(Icons.logout),
                  color: Colors.black,
                ))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        body: GetBuilder<ProfileController>(
          builder: (controller) => _controller.profileData == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        _buildProfileHeader(),
                        SizedBox(
                          height: 20.h,
                        ),
                        _buildProfileInformation(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Profile".tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('image/home/profile.png'),
              radius: 60,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              sharedPrefsClient.fullName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
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
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileInformation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Personal Information'.tr,
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          _buildInfoText('Username'.tr, _controller.info!.name),

          SizedBox(
            height: 7.h,
          ),
          _buildInfoText('email'.tr, _controller.info!.email),
          SizedBox(
            height: 7.h,
          ),
          _buildInfoText('phone'.tr, _controller.info!.phone),
          SizedBox(
            height: 7.h,
          ),
          _buildInfoText(
              'Business Name'.tr, _controller.profileData!.businessName),
          SizedBox(
            height: 7.h,
          ),
          _buildInfoText('Business Competence'.tr,
              _controller.profileData!.businessCompetence),
          // More text fields can be added similarly
        ],
      ),
    );
  }

  Widget _buildInfoText(
    String label,
    String value,
  ) {
    return Text(
      '$label : $value',
      style: TextStyle(fontSize: 12.sp),
    );
  }
}
