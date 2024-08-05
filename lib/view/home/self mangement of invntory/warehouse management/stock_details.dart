import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockDetails extends StatefulWidget {
  Map<String, dynamic> data;

  StockDetails({super.key, required this.data});

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(widget.data['name'], style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.04, horizontal: screenWidth * 0.05),
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.06),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.02,
                        horizontal: screenWidth * 0.03),
                    child: CircleAvatar(
                        backgroundImage:
                            Image.file(File('${widget.data['photo']}')).image,
                        radius: screenWidth * 0.16),
                  ),
                  Text(
                    widget.data['name'],
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text('${'Stock ID'.tr} : ${widget.data['id']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04)),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          '${'Subscription ID'.tr}: ${widget.data['subscriptionId']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04)),
                      widget.data['code'] == ''
                          ? SizedBox()
                          : SizedBox(
                              height: 15,
                            ),
                      widget.data['code'] == ''
                          ? SizedBox()
                          : Text('${'Stock Barcode'.tr}: ${widget.data['code']}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.04)),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Text('${'Stock Brand'.tr} : ${widget.data['brand']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.04)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          '${'Stock capacity'.tr}: ${widget.data['capacity']} ${'M²'.tr}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04)),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child:
                            Text('${'Upc stock'.tr} : ${widget.data['upc']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.04,
                                )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 320,
                        margin: EdgeInsets.only(bottom: screenWidth * 0.015),
                        child: Text(
                            '${'Stock description'.tr} : ${widget.data['description']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.043,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
