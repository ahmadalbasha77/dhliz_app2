import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

import '../../config/utils.dart';
import '../home/account_monitoring_screen.dart';
import '../home/self mangement of invntory/self_management_of_inventory_screen.dart';
import '../../config/shared_prefs_client.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _callNumber() async {
    var number = '0559559700';
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.01),
                child: Text(
                  "Inventory".tr,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.05,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // SizedBox(
              //   height: screenSize.height * 0.002,
              // ),
              _buildInventoryItem(
                  screenSize,
                  "Self management of inventory".tr,
                  "you can enter, withdraw, and transfer the inventory alone"
                      .tr,
                  'image/home/SELF.png',
                  () => Get.to(() => const SelfManagementOfInventoryScreen()),
                  'control panel',
                  Icon(
                    Icons.apps,
                    color: Colors.black,
                    size: screenSize.width * 0.045,
                  )),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              _buildInventoryItem(
                screenSize,
                "call customer care".tr,
                "you can add your inventory by customer care".tr,
                'image/home/Customer careCustomer care.png',
                _callNumber,
                'call now',
                Icon(
                  Icons.call,
                  color: Colors.black,
                  size: screenSize.width * 0.045,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.width * 0.02),
                child: Text(
                  "Monitoring".tr,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print('************************************');
                  print(sharedPrefsClient.accessToken);

                  print('************************************');
                  Get.to(() => const StockMonitoringScreen());
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(80, 46, 144, 1.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(screenSize.width * 0.045),
                            child: Text(
                              "Account Monitoring".tr,
                              style: TextStyle(
                                fontSize: screenSize.width * 0.048,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: 170,
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.035),
                            child: Text(
                              "Analysis of your inventory can be found".tr,
                              style: TextStyle(
                                fontSize: screenSize.width * 0.03,
                                color: Colors.white30,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: screenSize.width * 0.045,
                              horizontal: screenSize.width * 0.06,
                            ),
                            child: Text(
                              "view".tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.width * 0.035),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(screenSize.width * 0.005),
                        child: Image.asset(
                          'image/home/analytics.png',
                          width: screenSize.width * 0.33,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.width * 0.045,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInventoryItem(
    Size screenSize,
    String title,
    String description,
    String imagePath,
    Function() onTap,
    String text,
    Icon icon,
  ) {
    return Container(
      height: screenSize.height * 0.18,
      padding: EdgeInsets.symmetric(
        vertical: screenSize.width * 0.025,
        horizontal: screenSize.width * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(
        vertical: screenSize.width * 0.01,
        horizontal: screenSize.width * 0.04,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.044,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.03,
                    vertical: screenSize.width * 0.02,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.035,
                  ),
                  child: Container(
                    width: screenSize.width * 0.48,
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.029,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: screenSize.height * 0.0082,
                    left: screenSize.width * 0.045,
                    right: screenSize.width * 0.045,
                  ),
                  child: Row(
                    children: [
                      icon,
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        text.tr,
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Image.asset(
              imagePath,
              width: screenSize.width * 0.22,
              height: screenSize.height * 0.13,
            )
          ],
        ),
      ),
    );
  }
}
