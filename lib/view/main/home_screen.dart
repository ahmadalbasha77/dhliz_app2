import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../config/utils.dart';
import '../home/account_monitoring_screen.dart';
import '../home/self mangement of invntory/self_management_of_inventory_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _callNumber() async {
    var number = '0559559700';
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600; // Tablet threshold

    double basePadding = isTablet ? 20 : 11;
    double titleFontSize = isTablet ? 24 : 16;
    double descriptionFontSize = isTablet ? 16 : 12;

    return WillPopScope(
      onWillPop: () async {
        bool? exitConfirmed = await Utils.showExitConfirmationDialog(context);
        return exitConfirmed!;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Home".tr,
            style: TextStyle(
                color: Colors.black,
                fontSize: screenSize.width * (isTablet ? 0.03 : 0.045)),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(basePadding),
                child: Text(
                  "Inventory".tr,
                  style: TextStyle(
                      fontSize: screenSize.width * (isTablet ? 0.042 : 0.045),
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              _buildInventoryCard(
                  context,
                  screenSize,
                  "SELF.png",
                  "Self management of inventory".tr,
                  "you can enter, withdraw, and transfer the inventory alone"
                      .tr,
                  Icons.apps_rounded,
                  "control panel".tr),
              _buildInventoryCard(
                  context,
                  screenSize,
                  "Customer careCustomer care.png",
                  "call customer care".tr,
                  "you can add your inventory by customer care".tr,
                  Icons.call,
                  "call now".tr),
              Padding(
                padding: EdgeInsets.all(basePadding),
                child: Text(
                  "Monitoring".tr,
                  style: TextStyle(
                      fontSize: screenSize.width * (isTablet ? 0.042 : 0.045),
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
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
    );
  }

  Widget _buildInventoryCard(
      BuildContext context,
      Size screenSize,
      String imagePath,
      String title,
      String subtitle,
      IconData icon,
      String iconText) {
    bool isTablet = screenSize.width > 600;
    double widthMultiplier = isTablet ? 0.04 : 0.05;

    return Container(
      height: screenSize.width * (isTablet ? 0.3 : 0.3),
      margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * widthMultiplier, vertical: 10),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => Get.to(() => const SelfManagementOfInventoryScreen()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(title.tr,
                    style: TextStyle(
                        fontSize:
                            screenSize.width * (isTablet ? 0.04 : 0.042))),
                SizedBox(
                  width: screenSize.width * (isTablet ? 0.5 : 0.5),
                  child: Text(subtitle.tr,
                      style: TextStyle(
                          fontSize:
                              screenSize.width * (isTablet ? 0.022 : 0.028),
                          color: Colors.black38)),
                ),
                Row(
                  children: [
                    Icon(icon,
                        color: Colors.black,
                        size: screenSize.width * (isTablet ? 0.04 : 0.045)),
                    SizedBox(width: 5),
                    Text(iconText.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                screenSize.width * (isTablet ? 0.027 : 0.027))),
                  ],
                )
              ],
            ),
            Image.asset('image/home/$imagePath', width: screenSize.width * 0.25)
          ],
        ),
      ),
    );
  }

  Widget _buildMonitoringCard(BuildContext context, Size screenSize,
      String imagePath, String title, String subtitle, String buttonText) {
    bool isTablet = screenSize.width > 600;
    double widthMultiplier = isTablet ? 0.075 : 0.05;

    return InkWell(
      onTap: () => Get.to(() => const StockMonitoringScreen()),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * (isTablet ? 0.04 : 0.05),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromRGBO(80, 46, 144, 1.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.045),
                  child: Text(title.tr,
                      style: TextStyle(
                          fontSize: screenSize.width * 0.048,
                          color: Colors.white)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * (isTablet ? 0.035 : 0.04)),
                  width: screenSize.width * (isTablet ? 0.4 : 0.4),
                  child: Text(subtitle.tr,
                      style: TextStyle(
                          fontSize:
                              screenSize.width * (isTablet ? 0.028 : 0.032),
                          color: Colors.white30)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.width * 0.045,
                      horizontal: screenSize.width * 0.045),
                  child: Text(buttonText.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              screenSize.width * (isTablet ? 0.035 : 0.03))),
                ),
              ],
            ),
            Image.asset('image/home/$imagePath', width: screenSize.width * 0.3),
          ],
        ),
      ),
    );
  }
}
