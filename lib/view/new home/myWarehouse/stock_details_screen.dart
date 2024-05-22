
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/home/stock_model.dart';



class StockDetailsScreen extends StatelessWidget {
  final StockDataModel data;

  const StockDetailsScreen({super.key, required this.data});

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
        title: Text(data.name, style: const TextStyle(color: Colors.black)),
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
                        backgroundImage: NetworkImage(data.photo),
                        radius: screenWidth * 0.16),
                  ),
                  Text(
                    data.name,
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text('${'Stock ID'.tr} : ${data.id}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text('${'Subscription ID'.tr}: ${data.subscriptionId}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04)),
                      data.code == ''
                          ? const SizedBox()
                          : const SizedBox(
                              height: 15,
                            ),
                      data.code == ''
                          ? const SizedBox()
                          : Text('${'Stock Barcode'.tr}: ${data.code}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.04)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text('${'Stock Brand'.tr} : ${data.brand}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                          '${'Stock capacity'.tr}: ${data.capacity} ${'M²'.tr}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.04)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text('${'Upc stock'.tr} : ${data.upc}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.04,
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 320,
                        margin: EdgeInsets.only(bottom: screenWidth * 0.015),
                        child: Text(
                            '${'Stock description'.tr} : ${data.description}',
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
