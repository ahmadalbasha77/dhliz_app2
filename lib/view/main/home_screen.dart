import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

import '../home/self mangement of invntory/self_management_of_inventory_screen.dart';
import '../home/account_monitoring_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _callNumber() async {
    var number = '0777363661';
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
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
                  vertical: screenSize.height * 0.02),
              child: Text(
                "Inventory".tr,
                style: TextStyle(
                    fontSize: screenSize.width * 0.055,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              height: 140,
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.width * 0.025,
                  horizontal: screenSize.width * 0.001),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(
                  vertical: screenSize.width * 0.01,
                  horizontal: screenSize.width * 0.04),
              child: InkWell(
                onTap: () {
                  Get.to(SelfManagementOfInventoryScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            child: Text(
                              "Self management of inventory".tr,
                              style:
                                  TextStyle(fontSize: screenSize.width * 0.042),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.03,
                                vertical: screenSize.width * 0.02)),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.035),
                          child: Container(
                            width: 170,
                            child: Text(
                              "you can enter, withdraw, and transfer the inventory alone"
                                  .tr,
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.025,
                                  color: Colors.black38),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: screenSize.height * 0.0082,
                                left: screenSize.width * 0.045,
                                right: screenSize.width * 0.045),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.apps_rounded,
                                  color: Colors.black,
                                  size: screenSize.width * 0.045,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "control panel".tr,
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ))
                      ],
                    ),
                    Image.asset(
                      'image/home/SELF.png',
                      width: screenSize.width * 0.22,
                      height: screenSize.height * 0.13,
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 140,
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.width * 0.025,
                  horizontal: screenSize.width * 0.001),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(
                  vertical: screenSize.width * 0.01,
                  horizontal: screenSize.width * 0.04),
              child: InkWell(
                onTap: _callNumber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            child: Text(
                              "call customer care".tr,
                              style:
                                  TextStyle(fontSize: screenSize.width * 0.042),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.03,
                                vertical: screenSize.width * 0.02)),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.035),
                          child: Container(
                            width: 170,
                            child: Text(
                              "you can add your inventory by customer care".tr,
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.025,
                                  color: Colors.black38),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: screenSize.height * 0.0082,
                                left: screenSize.width * 0.045,
                                right: screenSize.width * 0.045),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.black,
                                  size: screenSize.width * 0.045,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "call now".tr,
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ))
                      ],
                    ),
                    Image.asset(
                      'image/home/Customer careCustomer care.png',
                      width: screenSize.width * 0.25,
                      height: screenSize.height * 0.13,
                      alignment: Alignment.topRight,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenSize.width * 0.05),
              child: Text(
                "Monitoring".tr,
                style: TextStyle(
                    fontSize: screenSize.width * 0.05,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(StockMonitoringScreen());
              },
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 40, 40, 51)),
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
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          width: 170,
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.035),
                          child: Text(
                              "Analysis of your inventory can be found".tr,
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.035,
                                  color: Colors.white30)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: screenSize.width * 0.045,
                              horizontal: screenSize.width * 0.06),
                          child: Text("view".tr,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(screenSize.width * 0.005),
                      child: Image.asset('image/home/analytics.png',
                          width: screenSize.width * 0.33),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
