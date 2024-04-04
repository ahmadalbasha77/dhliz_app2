import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'enter/inventory_warehouse.dart';
import 'warehouse management/my_warehouse_screen.dart';
import 'transfer/transfer_warehouse_screen.dart';
import 'withdrawd/withdraw_warehouse_screen.dart';

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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Self management of inventory'.tr,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.01),
                child: Text(
                  "Start Adding Warehouse".tr,
                  style: TextStyle(
                      fontSize: screenSize.width * 0.045,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenSize.width * 0.04)),
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                margin: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.003,
                    horizontal: screenSize.width * 0.06),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const MyWareHouseScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                                "Warehouse Management".tr,
                                style:
                                    TextStyle(fontSize: screenSize.width * 0.04),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.015,
                                  vertical: screenSize.height * 0.02)),
                          Container(
                            width: 180,
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.015),
                            child: Text(
                              "You can add warehouse and view warehouse list".tr,
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.028,
                                  color: Colors.black38),
                            ),
                          ),
                          Container(
                              child: Text(
                                "Management Now".tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.016,
                                  horizontal: screenSize.width * 0.035)),
                        ],
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
                height: 5,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.008),
                child: Text(
                  "operations".tr,
                  style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenSize.width * 0.04)),
                margin: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.005,
                    horizontal: screenSize.width * 0.06),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const InventoryWarehouse());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                                "Enter Inventory".tr,
                                style:
                                    TextStyle(fontSize: screenSize.width * 0.036),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.035,
                                  vertical: screenSize.height * 0.015)),
                          Container(
                            width: 150,
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
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.call_made_outlined,
                                    color: Colors.green,
                                    size: screenSize.width * 0.045,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Enter stock Now".tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.015,
                                  horizontal: screenSize.width * 0.035)),
                        ],
                      ),
                      Container(
                        child: Image.asset('image/home/Artboard 2.png',
                            width: screenSize.width * 0.3),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenSize.width * 0.04)),
                margin: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.005,
                    horizontal: screenSize.width * 0.06),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const WithdrawWarehouseScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Text(
                                  "Withdrawal of inventory".tr,
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.036),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.035,
                                    vertical: screenSize.height * 0.015)),
                            Container(
                              width: 160,
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
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.call_received,
                                      color: Colors.red,
                                      size: screenSize.width * 0.045,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Withdrawal Stock Now".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.015,
                                    horizontal: screenSize.width * 0.035)),
                          ]),
                      Container(
                        child: Image.asset(
                            'image/home/Withdrawal of inventoryWithdrawal of inventory.png',
                            width: screenSize.width * 0.3),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenSize.width * 0.04)),
                margin: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.005,
                    horizontal: screenSize.width * 0.06),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const TransferWarehouseScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                                "Transfer Inventory".tr,
                                style:
                                    TextStyle(fontSize: screenSize.width * 0.036),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.035,
                                  vertical: screenSize.height * 0.015)),
                          Container(
                            width: 160,
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
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.moving,
                                    color: Colors.green,
                                    size: screenSize.width * 0.045,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Transfer Stock Now".tr,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.015,
                                  horizontal: screenSize.width * 0.035)),
                        ],
                      ),
                      Container(
                        child: Image.asset('image/home/moving inventory.png',
                            width: screenSize.width * 0.3,
                            alignment: Alignment.topRight),
                      )
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
