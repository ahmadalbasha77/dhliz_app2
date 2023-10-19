import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';


import '../home/packges_screen/packges_screen.dart';
import '../home/self mangement of invntory/self_management_of_inventory_screen.dart';
import '../home/stock_monitoring_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _callNumber() async {
    var number = '0777363661';
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
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
          "Home",
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
                "Inventory",
                style: TextStyle(
                    fontSize: screenSize.width * 0.055,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SelfManagementOfInventoryScreen(),
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.symmetric(
                    vertical: screenSize.width * 0.01,
                    horizontal: screenSize.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  SelfManagementOfInventoryScreen(),
                            ));
                          },
                          child: Container(
                              child: Text(
                                "Self management of inventory",
                                style:
                                    TextStyle(fontSize: screenSize.width * 0.042),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.03,
                                  vertical: screenSize.width * 0.02)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.035),
                          child: Text(
                            "you can enter, withdraw, and transfer\nthe inventory alone",
                            style: TextStyle(
                                fontSize: screenSize.width * 0.025,
                                color: Colors.black38),
                          ),
                        ),
                        Container(
                            child: TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        SelfManagementOfInventoryScreen(),
                                  ));
                                },
                                icon: Icon(
                                  Icons.apps_rounded,
                                  color: Colors.black,
                                  size: screenSize.width * 0.045,
                                ),
                                label: Text(
                                  "control panel",
                                  style: TextStyle(color: Colors.black),
                                )),
                            margin: EdgeInsets.only(
                                top: screenSize.width * 0.025,
                                left: screenSize.width * 0.035)),
                      ],
                    ),
                    Container(
                      child: Image.asset('image/home/SELF.png',
                          width: screenSize.width * 0.24),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(
                  vertical: screenSize.width * 0.01,
                  horizontal: screenSize.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: _callNumber,
                        child: Container(
                            child: Text(
                              "call customer care",
                              style:
                                  TextStyle(fontSize: screenSize.width * 0.045),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.035,
                                vertical: screenSize.width * 0.02)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.035),
                        child: Text(
                          "you can add your inventory thought\ncustomer care",
                          style: TextStyle(
                              fontSize: screenSize.width * 0.025,
                              color: Colors.black38),
                        ),
                      ),
                      Container(
                          child: TextButton.icon(
                              onPressed: _callNumber,
                              icon: Icon(
                                Icons.call,
                                color: Colors.black87,
                                size: screenSize.width * 0.045,
                              ),
                              label: Text(
                                "call now",
                                style: TextStyle(color: Colors.black87),
                              )),
                          margin: EdgeInsets.only(
                              top: screenSize.width * 0.025,
                              left: screenSize.width * 0.035)),
                    ],
                  ),
                  Container(
                    child: Image.asset(
                      'image/home/Customer careCustomer care.png',
                      width: screenSize.width * 0.3,
                      alignment: Alignment.topRight,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenSize.width * 0.05),
              child: Text(
                "Monitoring",
                style: TextStyle(
                    fontSize: screenSize.width * 0.05,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StockMonitoringScreen(),
                ));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
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
                            "Account Monitoring",
                            style: TextStyle(
                                fontSize: screenSize.width * 0.048,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.035),
                          child: Text("Analysis of your inventory\ncan be found",
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.035,
                                  color: Colors.white30)),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: screenSize.width * 0.045,
                              left: screenSize.width * 0.005),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StockMonitoringScreen(),
                              ));
                            },
                            child: Text("view",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(screenSize.width * 0.005),
                      child: Image.asset('image/home/analytics.png',
                          width: screenSize.width * 0.35),
                    )
                  ],
                ),
              ),
            ),
            Container(
              
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.04,
                  vertical: screenSize.height * .021),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(

                        margin: EdgeInsets.all(screenSize.width * 0.01),
                        child: Text(
                          "Subscription packages",
                          style: TextStyle(
                              fontSize: screenSize.width * 0.036,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        width: screenSize.width * .3,
                        margin: EdgeInsets.only(
                            top: screenSize.width * 0.04,
                            bottom: screenSize.height * 0.01,
                            left: screenSize.width * 0.005),
                        child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17))),
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 40, 40, 51))),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PackgesScreen(),
                            ));
                          },
                          child:
                              Text("view", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(screenSize.width * 0.005),
                    child: Image.asset(
                        'image/dehliz/undraw_discount_d4bd-removebg-preview.png',
                        width: screenSize.width * 0.35),
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
