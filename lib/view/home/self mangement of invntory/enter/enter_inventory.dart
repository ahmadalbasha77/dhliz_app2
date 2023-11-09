import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'enter_inventory/add_temprature.dart';
import 'my_warehouse/my_warehouse_screen.dart';

class EnterInventory extends StatefulWidget {
  const EnterInventory({super.key});

  @override
  State<EnterInventory> createState() => _EnterInventoryState();
}

class _EnterInventoryState extends State<EnterInventory> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Inventory', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05,
                vertical: screenSize.height * 0.01),
            child: Text(
              "operation",
              style: TextStyle(
                  fontSize: screenSize.width * 0.05,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.02,
                horizontal: screenSize.width * 0.02),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenSize.width * 0.04)),
            margin: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.005,
                horizontal: screenSize.width * 0.06),
            child: InkWell(
              onTap: () {
                Get.to(AddTemperature());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                            "Adding Stock to New \nWarehouse",
                            style:
                                TextStyle(fontSize: screenSize.width * 0.036),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.035,
                              vertical: screenSize.height * 0.015)),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.035),
                        child: Text(
                          "Your inventory can be added \nto the warehouse",
                          style: TextStyle(
                              fontSize: screenSize.width * 0.024,
                              color: Colors.black38),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      child: Icon(
                    Icons.add,
                    size: 80,
                  ))
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.02,
                horizontal: screenSize.width * 0.02),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenSize.width * 0.04)),
            margin: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.017,
                horizontal: screenSize.width * 0.06),
            child: InkWell(
              onTap: () {
                Get.to(MyWareHouseScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                            "Adding Stock to My \nWarehouse",
                            style:
                                TextStyle(fontSize: screenSize.width * 0.036),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.035,
                              vertical: screenSize.height * 0.015)),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.035),
                        child: Text(
                          "You can withdraw your inventory \nfrom the warehouse",
                          style: TextStyle(
                              fontSize: screenSize.width * 0.024,
                              color: Colors.black38),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Image.asset(
                        'image/home/warehouse ManagementManagement.png',
                        width: screenSize.width * 0.3),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
