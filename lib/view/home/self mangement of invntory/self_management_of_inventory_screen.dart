import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../new home/enter inventory/enter_warehouse_screen.dart';
import '../../new home/myWarehouse/my_warehouse_screen.dart';
import '../../new home/transfer inventory/transfer_warehouse_screen.dart';
import '../../new home/withdrawal inventory/withdrawal_warehouse_screen.dart';

class SelfManagementOfInventoryScreen extends StatefulWidget {
  const SelfManagementOfInventoryScreen({Key? key}) : super(key: key);

  @override
  State<SelfManagementOfInventoryScreen> createState() =>
      _SelfManagementOfInventoryScreenState();
}

class _SelfManagementOfInventoryScreenState
    extends State<SelfManagementOfInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Self management of inventory'.tr,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Start Adding Warehouse".tr,
                style: TextStyle(
                    fontSize: 15.w,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04)),
                padding: EdgeInsets.only(
                    left: 14.w, right: 14.w, top: 15.h, bottom: 10.h),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const MyWarehousesScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Warehouse Management".tr,
                              style:
                                  TextStyle(fontSize: screenSize.width * 0.04),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "You can add warehouse and view warehouse list"
                                  .tr,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black38),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Management Now".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.width * 0.027,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'image/home/warehouse ManagementManagement.png',
                        width: screenSize.width * 0.28,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "operations".tr,
                style: TextStyle(
                    fontSize: 15.w,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04)),
                // margin: EdgeInsets.symmetric(
                //     vertical: screenSize.height * 0.005,
                //     horizontal: screenSize.width * 0.06),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const EnterWarehouseScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.035,
                                  vertical: screenSize.height * 0.015),
                              child: Text(
                                "Enter Inventory".tr,
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.036),
                              )),
                          Container(
                            width: 150.w,
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.035),
                            child: Text(
                              "Your inventory can be added to the warehouse".tr,
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.024,
                                  color: Colors.black38),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.015,
                                  horizontal: screenSize.width * 0.035),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.call_made_outlined,
                                    color: Colors.green,
                                    size: screenSize.width * 0.045,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Enter stock Now".tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenSize.width * 0.023,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        ],
                      ),
                      Image.asset('image/home/Artboard 2.png',
                          width: screenSize.width * 0.3)
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04)),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const WithdrawalWarehouseNewScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.035,
                                    vertical: screenSize.height * 0.015),
                                child: Text(
                                  "Withdrawal of inventory".tr,
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.036),
                                )),
                            Container(
                              width: 160.w,
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.035),
                              child: Text(
                                "You can withdraw your inventory from the warehouse"
                                    .tr,
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.024,
                                    color: Colors.black38),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.015,
                                    horizontal: screenSize.width * 0.035),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.call_received,
                                      color: Colors.red,
                                      size: screenSize.width * 0.045,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Withdrawal Stock Now".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenSize.width * 0.023,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )),
                          ]),
                      Image.asset(
                          'image/home/Withdrawal of inventoryWithdrawal of inventory.png',
                          width: screenSize.width * 0.3)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04)),
                // margin: EdgeInsets.symmetric(
                //     vertical: screenSize.height * 0.005,
                //     horizontal: screenSize.width * 0.06),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const TransferWarehouseNewScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.035,
                                  vertical: screenSize.height * 0.015),
                              child: Text(
                                "Transfer Inventory".tr,
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.036),
                              )),
                          Container(
                            width: 160.w,
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.035),
                            child: Text(
                              "You can transfer your inventory to the anther warehouse"
                                  .tr,
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.024,
                                  color: Colors.black38),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.015,
                                  horizontal: screenSize.width * 0.035),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.moving,
                                    color: Colors.green,
                                    size: screenSize.width * 0.045,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Transfer Stock Now".tr,
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.023,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        ],
                      ),
                      Image.asset('image/home/moving inventory.png',
                          width: screenSize.width * 0.3,
                          alignment: Alignment.topRight)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
