import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../config/utils.dart';
import '../home/account_monitoring_screen.dart';
import '../home/self mangement of invntory/self_management_of_inventory_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _callNumber() async {
    var number = '0559559700';
    print(number);
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600; // Tablet threshold

    double basePadding = isTablet ? 20 : 11;

    return WillPopScope(
      onWillPop: () async {
        bool? exitConfirmed = await Utils.showExitConfirmationDialog(context);
        return exitConfirmed!;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Home".tr,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Inventory".tr,
                  style: TextStyle(
                      fontSize: 15.w,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _buildInventoryCard(
                  context,
                  screenSize,
                  "SELF.png",
                  "Self management of inventory".tr,
                  "you can enter, withdraw, and transfer the inventory alone"
                      .tr,
                  Icons.apps_rounded,
                  "control panel".tr,
                  () => Get.to(
                    () => const SelfManagementOfInventoryScreen(),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _buildInventoryCard(
                    context,
                    screenSize,
                    "Customer careCustomer care.png",
                    "call customer care".tr,
                    "you can add your inventory by customer care".tr,
                    Icons.call,
                    "call now".tr,
                    _callNumber),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Monitoring".tr,
                  style: TextStyle(
                      fontSize: 15.w,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15.h,
                ),
                _buildMonitoringCard(
                    context,
                    screenSize,
                    "analytics.png",
                    "Account Monitoring".tr,
                    "Analysis of your inventory can be found".tr,
                    "view".tr),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInventoryCard(
      BuildContext context,
      Size screenSize,
      String imagePath,
      String title,
      String subtitle,
      IconData icon,
      String iconText,
      Function()? onTap) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title.tr, style: TextStyle(fontSize: 13.sp)),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(subtitle.tr,
                      style: TextStyle(fontSize: 10.sp, color: Colors.black38)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Icon(icon, color: Colors.black, size: 15.w),
                      SizedBox(width: 5.h),
                      Text(iconText.tr, style: TextStyle(fontSize: 10.sp)),
                    ],
                  )
                ],
              ),
            ),
            Image.asset('image/home/$imagePath', width: 80.w)
          ],
        ),
      ),
    );
  }

  Widget _buildMonitoringCard(BuildContext context, Size screenSize,
      String imagePath, String title, String subtitle, String buttonText) {
    return InkWell(
      onTap: () => Get.to(() => const StockMonitoringScreen()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(80, 46, 144, 1.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title.tr,
                      style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(subtitle.tr,
                      style: TextStyle(fontSize: 12.sp, color: Colors.white30)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(buttonText.tr,
                      style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                ],
              ),
            ),
            Image.asset('image/home/$imagePath', width: screenSize.width * 0.3),
          ],
        ),
      ),
    );
  }
}
