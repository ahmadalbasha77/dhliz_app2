import 'package:dhliz_app/view/main/profile/settings/terms_condition_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../config/constant.dart';
import '../../../../config/shared_prefs_client.dart';
import '../../../../config/utils.dart';
import '../../../../controllers/main/profile_controller.dart';
import '../../../../widgets/src/custom_single_child_scroll_view.dart';
import '../../../../widgets/src/custom_widget.dart';
import '../../../auth/login_screen.dart';
import 'edit_profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // final _controller = ProfileController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   _controller.getProfile();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      alignment: Alignment.topCenter,
      child: CustomSingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  // Center(
                  //   child: Text(
                  //     "${'Expiration'.tr}: }",
                  //     style: kStyleTextExpiration,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.h, right: 25.w, left: 25.w, bottom: 30.h),
                    child: Text("Settings".tr, style: kStyleTextTitleLarge),
                  ),
                  Material(
                    color: Colors.white,
                    child: Column(
                      children: [
                        // ListTile(
                        //   title: Text('Edit Profile'.tr),
                        //   leading: const Icon(FontAwesomeIcons.person, color: Colors.black),
                        //   trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        //   onTap: () {
                        //     Get.to(() => EditProfileScreen(profile: _controller.profile.value))?.then((value) => _controller.getProfile());
                        //   },
                        // ),
                        // ListTile(
                        //   title: Text('History'.tr),
                        //   leading: const Icon(FontAwesomeIcons.clockRotateLeft, color: Colors.black),
                        //   trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        // ),
                        ListTile(
                          title: Text('Contact Us'.tr),
                          leading: const Icon(FontAwesomeIcons.headset,
                              color: Colors.black),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.black),
                          onTap: () {
                            Get.defaultDialog(
                              title: 'Contact Us'.tr,
                              content: Text(
                                  '${'Call the following number for assistance'.tr}.\ntel: $phoneNumber'),
                              textCancel: 'Close'.tr,
                              textConfirm: 'Call'.tr,
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Get.back();
                                launchUrlString('tel:$phoneNumber');
                              },
                              barrierDismissible: true,
                            );
                          },
                        ),
                        ListTile(
                          title: Text('Language'.tr),
                          leading: const Icon(FontAwesomeIcons.language,
                              color: Colors.black),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.black),
                          onTap: () {
                            Get.defaultDialog(
                              title: 'Language'.tr,
                              content: Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      sharedPrefsClient.language = 'en';
                                      Get.updateLocale(
                                          Locale(sharedPrefsClient.language));
                                      Get.back();
                                    },
                                    title: const Text('English'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      sharedPrefsClient.language = 'ar';
                                      Get.updateLocale(
                                          Locale(sharedPrefsClient.language));
                                      Get.back();
                                    },
                                    title: const Text('العربية'),
                                  ),
                                ],
                              ),
                              barrierDismissible: true,
                            );
                          },
                        ),
                        // ListTile(
                        //   title: Text('Delete Account'.tr),
                        //   leading: const Icon(FontAwesomeIcons.deleteLeft,
                        //       color: Colors.black),
                        //   trailing: const Icon(Icons.arrow_forward_ios,
                        //       color: Colors.black),
                        //   onTap: () async {
                        //     const url = "https://www.google.com/";
                        //     final Uri _url = Uri.parse(url);
                        //
                        //     await launchUrl(_url,
                        //         mode: LaunchMode.externalApplication);
                        //   },
                        // ),
                        ListTile(
                          title: Text('Terms & Conditions'.tr),
                          leading: const Icon(FontAwesomeIcons.gavel,
                              color: Colors.black),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.black),
                          onTap: () {
                            Get.to(TermsConditionScreen());
                          },
                        ),
                        ListTile(
                          title: Text('Delete Account'.tr),
                          leading: const Icon(CupertinoIcons.delete_right_fill,
                              color: Colors.black),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.black),
                          onTap: () async {
                            await launchUrl(
                                Uri.parse('https://deleteaccount.dhlez.sa/'));
                          },
                        ),
                        ListTile(
                          title: Text('Sign Out'.tr),
                          leading: const Icon(
                              FontAwesomeIcons.arrowRightFromBracket,
                              color: Colors.black),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.black),
                          onTap: () async {
                            if (await Utils.showAreYouSureDialog(
                                title: 'Sign Out'.tr)) {
                              sharedPrefsClient.clearProfile();
                              Get.deleteAll();
                              Get.offAll(() =>  LoginScreen());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
