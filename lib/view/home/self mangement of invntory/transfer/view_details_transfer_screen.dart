import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../network/api_url.dart';

class ViewDetailsTransferScreen extends StatefulWidget {
  int id;
  String nameWarehouse;
  String desWarehouse;
  String image;
  List<Map<String, dynamic>> data;

  ViewDetailsTransferScreen(
      {Key? key,
      required this.id,
      required this.nameWarehouse,
      required this.desWarehouse,
      required this.data,
      required this.image})
      : super(key: key);

  @override
  State<ViewDetailsTransferScreen> createState() =>
      _ViewDetailsTransferScreenState();
}

class _ViewDetailsTransferScreenState extends State<ViewDetailsTransferScreen> {
  List<Map<String, dynamic>> data = [];

  void postData() async {
    final String apiUrl = '${ApiUrl.API_BASE_URL}/Transaction/Create';

    Map<String, dynamic> requestBody = {
      "quantity": int.parse(space.text),
      "actionType": 2,
      "fromStockId": widget.id,
      "toStockId": selected,
      "rejectReason": "string"
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("POST request successful!");
      print("Response: ${response.body}");

      // Parse the JSON response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      Get.back();
      // Now you can use the postId variable as needed.
    } else {
      print("Failed to make POST request. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  }

  TextEditingController space = TextEditingController();
  var selected;

  @override
  void initState() {
    print('+++++++++++++++++++');
    data = widget.data;
    print(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.nameWarehouse,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            backgroundImage:
                                Image.file(File(widget.image)).image,
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
                        child: Text(widget.nameWarehouse,
                            style: TextStyle(fontSize: screenWidth * 0.05)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.008),
                        child: Text(widget.id.toString(),
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: screenWidth * 0.026)),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: screenWidth * 0.02,
                            left: screenWidth * 0.008,
                            bottom: screenWidth * 0.015),
                        child: Text('Description'.tr),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: screenWidth * 0.002,
                            left: screenWidth * 0.008,
                            bottom: screenWidth * 0.015),
                        child: Text(widget.desWarehouse,
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
                    child: Text('${'Address WH'.tr} : amman',
                        style: TextStyle(color: Colors.black54)),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: screenWidth * 0.02,
                        left: screenWidth * 0.07,
                        right: screenWidth * 0.07,
                        top: screenWidth * 0.015),
                    child: Text('${'Warehouse name'.tr} : wh1',
                        style: TextStyle(color: Colors.black54)),
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
                  '${'The space to be transfer'.tr} : ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 38, 50, 56),
                      fontWeight: FontWeight.w500),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                  controller: space,
                  decoration: InputDecoration(
                      suffixText: 'M²',
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
            Container(
              margin: EdgeInsets.only(
                  top: screenWidth * 0.04,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenWidth * 0.02),
              child: Text('Transfer to'.tr,
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
                      'Warehouse name'.tr,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                value: selected,
                onChanged: (val) {
                  setState(() {
                    selected = val;
                    print(selected);
                  });
                },
                items: data.map((item) {
                  return DropdownMenuItem(
                    value: item['id'],
                    // Adjust this based on your data structure
                    child: Text(
                      item['id'].toString(),
                      // Adjust this based on your data structure
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: screenWidth * 0.35,
            ),
            Center(
              child: SizedBox(
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
                      postData();
                    },
                    child: Text("Transfer now".tr)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
