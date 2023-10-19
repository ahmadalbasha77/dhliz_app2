import 'package:flutter/material.dart';
import 'enter/enter_inventory.dart';
import 'enter/my_warehouse/my_warehouse_screen.dart';
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
            "Self management of inventory",
            style: TextStyle(color: Colors.black),
          ),
          titleSpacing: screenSize.width * 0.14,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenSize.width * 0.04)),
              margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.005,
                  horizontal: screenSize.width * 0.06),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EnterInventory(),
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                              "Enter Inventory",
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
                            "Your invntory can be added to\nthe werehous",
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
                                Text(
                                  " Enter stock Now",
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WithdrawWarehouseScreen(),
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                                "Withdrawad of inventory",
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.036),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.035,
                                  vertical: screenSize.height * 0.015)),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.035),
                            child: Text(
                              "you can withdrawad your invmtory\nfrom the werehous",
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
                                  Text(
                                    " Withdrawad Stock Now",
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TransferWarehouseScreen(),
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                              "Transfer Inventory",
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
                            "you can add your inventory thought\ncustomer care",
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
                                Text(
                                  " Transfer Stock Now",
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
            SizedBox(
              height: 110,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenSize.width * 0.04)),
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
              margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.005,
                  horizontal: screenSize.width * 0.06),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyWareHouseScreen(),
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                              "Warehouse Management",
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
                            "You can add warehouse and view \nwarehouse list",
                            style: TextStyle(
                                fontSize: screenSize.width * 0.024,
                                color: Colors.black38),
                          ),
                        ),
                        Container(
                            child: Text(
                              "Management Now",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.016,
                                horizontal: screenSize.width * 0.035)),
                      ],
                    ),
                    Image.asset('image/home/warehouse ManagementManagement.png',
                        width: screenSize.width * 0.3)
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
