import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../config/shared_prefs_client.dart';
import '../../../../network/api_url.dart';

class InventoryDetailsScreen extends StatefulWidget {
  Map<String, dynamic> data;

  InventoryDetailsScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<InventoryDetailsScreen> createState() => _InventoryDetailsScreenState();
}

class _InventoryDetailsScreenState extends State<InventoryDetailsScreen> {
  void postData() async {
    final String apiUrl = '${ApiUrl.API_BASE_URL}/Transaction/Create';

    Map<String, dynamic> requestBody = {
      "id": 0,
      "quantity": space.text,
      "actionType": 1,
      "status": 0,
      "fromStockId": widget.data['id'],
      "toStockId": widget.data['id'],
      "rejectReason": "string"
    };
    print(requestBody);

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPrefsClient.accessToken}',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("POST request successful!");
      // print("Response: ${response.body}");

      // Parse the JSON response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      Get.back();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text:
        'A new entry transaction request has been sent. Please wait for approval',
        showConfirmBtn: true,
        confirmBtnColor: Colors.white,
        confirmBtnTextStyle: TextStyle(color: Colors.black),
        title: 'Completed Successfully!',
        textAlignment: TextAlign.center
      );
      // Now you can use the postId variable as needed.
    } else {
      print("Failed to make POST request. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  }

  String? x;
  var selected;
  TextEditingController date = TextEditingController();
  TextEditingController space = TextEditingController();

  void initState() {
    date.text = "";
    print(widget.data);
    super.initState();
  }

  bool isSelectedOne = false;
  bool isSelectedOTwo = false;

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
        title: Text('Enter Stock', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.04, horizontal: screenWidth * 0.05),
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
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
                            backgroundImage: Image.file(File(
                                    widget.data['photo'] ??
                                        widget.data['Photo']))
                                .image,
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
                            bottom: screenWidth * 0.01),
                        child: Text(widget.data['name'] ?? widget.data['Name'],
                            style: TextStyle(fontSize: screenWidth * 0.047)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.008),
                        child: Text(
                            '${'Stock ID'.tr} : ${widget.data['id'] ?? widget.data['Id']}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: screenWidth * 0.026)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        child: Text(
                            '${'Barcode'.tr}: ${widget.data['code'] ?? widget.data['Code']}',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        child: Text(
                            '${"The number".tr}: ${widget.data['upc'] ?? widget.data['UPC']}',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 230,
                        margin: EdgeInsets.only(bottom: screenWidth * 0.015),
                        child: Text(
                            widget.data['description'] ??
                                widget.data['Description'],
                            style:
                                TextStyle(color: Colors.black87, fontSize: 13)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.02,
                    horizontal: screenWidth * 0.05),
                child: Text(
                  '${'The space to be enter'.tr} :',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 38, 50, 56),
                      fontWeight: FontWeight.w500),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: space,
                  decoration: InputDecoration(
                      suffixText: 'M²'.tr,
                      suffixStyle:
                          TextStyle(fontSize: 16, color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      label: Text('space'.tr,
                          style: TextStyle(color: Colors.black54)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.02,
                    horizontal: screenWidth * 0.05),
                child: Text(
                  'Enter date'.tr,
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 38, 50, 56),
                      fontWeight: FontWeight.w500),
                )),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: TextField(
                  readOnly: true,
                  controller: date,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        date.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month_sharp),
                    filled: true,
                    fillColor: Colors.white,
                    label: Text('date'.tr,
                        style: TextStyle(color: Colors.black54)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                  )),
            ),
            SizedBox(
              height: 170,
            ),
            // Center(
            //   child: Container(
            //     width: 350,
            //     margin: EdgeInsets.symmetric(horizontal: 20),
            //     child: Text(
            //         textAlign: TextAlign.center,
            //         'Note: The stock to be stored must be the same as the stored stock'
            //             .tr,
            //         style: TextStyle(
            //             fontSize: 14,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.black54)),
            //   ),
            // ),
            Center(
              child: Container(
                width: 270,
                height: 60,
                margin: EdgeInsets.only(top: 25),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(80, 46, 144, 1.0)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      postData();
                    },
                    child: Text('Enter Now'.tr)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
