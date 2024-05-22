import 'dart:convert';

import 'package:dhliz_app/view/new%20home/myWarehouse/my_warehouse_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

import '../../../../../config/app_color.dart';
import '../../../../../config/shared_prefs_client.dart';
import '../../../../../network/api_url.dart';
import 'payment_screen.dart';
import 'invoice_screen.dart';

class PayScreen extends StatefulWidget {
  double totalAmount;
  int customerId;
  String warehouseId;
  String warehouseName;
  String inventoryDescription;
  String expiredDate;
  String address;
  int capacity;
  double price;
  double transportationFees;
  String space;
  String from;
  String to;
  bool dry;
  bool cold;
  bool freezing;

  PayScreen({
    super.key,
    required this.totalAmount,
    required this.customerId,
    required this.warehouseId,
    required this.warehouseName,
    required this.inventoryDescription,
    required this.capacity,
    required this.expiredDate,
    required this.address,
    required this.price,
    required this.transportationFees,
    required this.space,
    required this.from,
    required this.to,
    required this.dry,
    required this.cold,
    required this.freezing,
  });

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  int calculateTotalPrice() {
    return int.parse(((widget.price * widget.capacity).round()).toString());
  }

  @override
  void initState() {
    super.initState();
    print(widget.customerId);
    print(widget.space);
    print(widget.warehouseId);
    print('==============================');
  }

  void postData() async {
    final String apiUrl = '${ApiUrl.API_BASE_URL2}/api/Subscription/Create';

    Map<String, dynamic> requestBody = {
      "reservedSpace": widget.capacity.toString(),
      "customerId": '${sharedPrefsClient.customerId}',
      "warehouseId": widget.warehouseId,
      'startDate': widget.from,
      'endDate': widget.to,
      'inventoryDescription': widget.inventoryDescription,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${sharedPrefsClient.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("POST request successful!");
      print("555555555555555555555555555555!");
      Get.off(() => MyWarehousesScreen());
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Send subscription request successfully!',
        showConfirmBtn: false,
      );
    } else {
      print("Failed to make POST request. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      print("Request Body: $requestBody");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Subscription Details'.tr,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text('${'Expired WH'.tr} : ${widget.to} ',
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.warehouseName,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('${'Address'.tr} : ${widget.address}',
                    style: TextStyle(
                      fontSize: 11,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child:
                      Text('${'Price'.tr} : ${widget.price} SAR / 1 M2 per day',
                          style: TextStyle(
                            fontSize: 11,
                          )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                      '${'Transportation Fees'.tr} : ${widget.transportationFees} SAR ',
                      style: TextStyle(
                        fontSize: 11,
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text('${"Temperature".tr}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Row(children: [
                      AbsorbPointer(
                        absorbing: true,
                        child: Checkbox(
                          fillColor: MaterialStatePropertyAll(Colors.black),
                          value: widget.dry,
                          onChanged: (value) {},
                        ),
                      ),
                      Text(
                        'Dry'.tr,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ])),
                    Row(children: [
                      AbsorbPointer(
                        absorbing: true,
                        child: Checkbox(
                          fillColor: MaterialStatePropertyAll(Colors.black),
                          value: widget.cold,
                          onChanged: (bool? value) {},
                        ),
                      ),
                      Text(
                        'Cold'.tr,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ]),
                    Row(children: [
                      AbsorbPointer(
                        absorbing: true,
                        child: Checkbox(
                          fillColor: MaterialStatePropertyAll(Colors.black),
                          value: widget.freezing,
                          onChanged: (bool? value) {},
                        ),
                      ),
                      Text(
                        'Freezing'.tr,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ]),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                // Row(
                //   children: [
                //     Text('${'Used'.tr}',
                //         style: TextStyle(fontSize: 14, color: Colors.black54)),
                //     LinearPercentIndicator(
                //       barRadius: Radius.circular(15),
                //       width: 250,
                //       lineHeight: 14.0,
                //       percent: .0,
                //       backgroundColor: Colors.grey,
                //       progressColor: Colors.black,
                //     ),
                //     Text(
                //       '0%',
                //       style: TextStyle(fontSize: 14),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${'space'.tr} :${widget.space} ${'M²'.tr}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('${'Total price'.tr} : ${widget.totalAmount} ${'SR'.tr}',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 300,
            height: 55,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStatePropertyAll(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                backgroundColor: MaterialStateProperty.all(
                  AppColor.buttonColor,
                ),
              ),
              onPressed: () {
                final totalPrice = calculateTotalPrice();
                postData();
                print('888888888888888888888888888888');
                print(sharedPrefsClient.customerId);
                print('888888888888888888888888888888');
                // Get.off(PaymentScreen(
                //   from: widget.from,
                //   to: widget.to,
                //   amount: widget.totalAmount,
                //   customerId: sharedPrefsClient.customerId,
                //   capacity: widget.capacity,
                //   warehouseId: widget.warehouseId,
                //   warehouseName: widget.warehouseName,
                //   dry: widget.dry,
                //   cold: widget.cold,
                //   freezing: widget.freezing,
                //   address: widget.address,
                // ));
              },
              child: Text(
                'Send subscription request'.tr,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
