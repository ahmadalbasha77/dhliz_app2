import 'package:flutter/material.dart';

class ViewDetailsTransferScreen extends StatefulWidget {
  String id;

  ViewDetailsTransferScreen({required this.id, Key? key}) : super(key: key);

  @override
  State<ViewDetailsTransferScreen> createState() =>
      _ViewDetailsTransferScreenState();
}

class _ViewDetailsTransferScreenState extends State<ViewDetailsTransferScreen> {
  @override
  Widget build(BuildContext context) {
    var selected;

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'wh',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.03, horizontal: screenWidth * 0.05),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.02,
                            horizontal: screenWidth * 0.03),
                        child: CircleAvatar(
                            backgroundImage: AssetImage(''),
                            radius: screenWidth * 0.12),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: screenWidth * 0.04,
                            left: screenWidth * 0.008,
                            bottom: screenWidth * 0.01),
                        child: Text('wh',
                            style: TextStyle(fontSize: screenWidth * 0.05)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.008),
                        child: Text('110',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: screenWidth * 0.026)),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: screenWidth * 0.02,
                            left: screenWidth * 0.008,
                            bottom: screenWidth * 0.015),
                        child: Text('Description'),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: screenWidth * 0.002,
                            left: screenWidth * 0.008,
                            bottom: screenWidth * 0.015),
                        child: Text('aaaa',
                            style: TextStyle(
                                fontSize: screenWidth * 0.025,
                                color: Colors.black54)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.01, horizontal: screenWidth * 0.05),
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenWidth * 0.04),
                    child: Text('Warehouse name',
                        style: TextStyle(fontSize: screenWidth * 0.045)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.07,
                        vertical: screenWidth * 0.015),
                    child: Text('Address WH : amman',
                        style: TextStyle(color: Colors.black54)),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: screenWidth * 0.02,
                        left: screenWidth * 0.07,
                        top: screenWidth * 0.015),
                    child: Text('Warehouse name : wh1',
                        style: TextStyle(color: Colors.black54)),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  top: screenWidth * 0.04,
                  left: screenWidth * 0.05,
                  bottom: screenWidth * 0.02),
              child: Text('Transfer to',
                  style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w500)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.05,
                    horizontal: screenWidth * 0.025,
                  ),
                  label: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                    ),
                    child: Text(
                      'Warehouse name',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                value: selected,
                onChanged: (val) {
                  setState(() {
                    selected = val;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Warehouse 1 ',
                    child: Text(
                      "Warehouse 1",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Warehouse 2',
                    child: Text(
                      "Warehouse 2 ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Warehouse 3',
                    child: Text(
                      "Warehouse 3",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Warehouse 4 ',
                    child: Text(
                      "Warehouse 4",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenWidth * 0.6,
            ),
            Container(
              width: screenWidth * 0.7,
              height: screenWidth * 0.14,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 35, 37, 56)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03)))),
                  onPressed: () {
                    // Handle Transfer button press
                  },
                  child: Text("Transfer")),
            )
          ],
        ),
      ),
    );
  }
}
