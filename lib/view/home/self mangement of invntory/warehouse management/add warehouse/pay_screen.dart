import 'dart:convert';

import 'package:dhliz_app/view/new%20home/myWarehouse/my_warehouse_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

import '../../../../../config/app_color.dart';
import '../../../../../config/shared_prefs_client.dart';
import '../../../../../network/api_url.dart';
import 'map_screen.dart';

class PayScreen extends StatefulWidget {
  final MarkerInfo info;
  final double totalAmount;
  final double cost;
  final String inventoryDescription;
  final int capacity;
  final String temp;
  final int tempId;
  final String from;
  final String to;

  const PayScreen({
    super.key,
    required this.totalAmount,
    required this.cost,
    required this.inventoryDescription,
    required this.capacity,
    required this.from,
    required this.temp,
    required this.tempId,
    required this.to,
    required this.info,
  });

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  // int calculateTotalPrice() {
  //   return int.parse(((widget.price * widget.capacity).round()).toString());
  // }

  @override
  void initState() {
    super.initState();
    print(widget.capacity);
    print(widget.info.id);
    print('==============================');
  }

  bool isLoading = false;

  void postData() async {
    setState(() {
      isLoading = true;
    });
    final String apiUrl =
        '${ApiUrl.API_BASE_URL2}/api/Subscription/Create/CreateAsync';

    Map<String, dynamic> requestBody = {
      "reservedSpace": widget.capacity.toString(),
      "customerId": sharedPrefsClient.customerId,
      "warehouseId": widget.info.id,
      'startDate': widget.from,
      'endDate': widget.to,
      'inventoryDescription': widget.inventoryDescription,
      'supTemperatureId': widget.tempId,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${sharedPrefsClient.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    var result = jsonDecode(response.body);
    print(result);
    print(result['isSuccess']);
    if (response.statusCode == 200) {
      if (result['isSuccess'] == true) {
        Get.off(() => MyWarehousesScreen());
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Send subscription request successfully !'.tr,
          showConfirmBtn: false,
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Error Send subscription request!'.tr,
          showConfirmBtn: false,
        );
      }
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Error Send subscription request!',
        showConfirmBtn: false,
      );
      print("Failed to make POST request. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      print("Request Body: $requestBody");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
                        widget.info.nameWarehouse,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('${'Address'.tr} : ${widget.info.address}',
                    style: TextStyle(
                      fontSize: 12,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child:
                      Text('${'Price'.tr} : ${widget.cost}  SAR / M² per day',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('${'Transportation Fees'.tr} : ${0} SAR ',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                      '${'Inventory Description'.tr} : ${widget.inventoryDescription} SAR ',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text('${"Temperature".tr} : ${widget.temp} °C',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //         child: Row(children: [
                //       AbsorbPointer(
                //         absorbing: true,
                //         child: Checkbox(
                //           fillColor: MaterialStatePropertyAll(Colors.black),
                //           value: widget.dry,
                //           onChanged: (value) {},
                //         ),
                //       ),
                //       Text(
                //         'Dry'.tr,
                //         style: TextStyle(
                //           fontSize: 12,
                //         ),
                //       ),
                //     ])),
                //     Row(children: [
                //       AbsorbPointer(
                //         absorbing: true,
                //         child: Checkbox(
                //           fillColor: MaterialStatePropertyAll(Colors.black),
                //           value: widget.cold,
                //           onChanged: (bool? value) {},
                //         ),
                //       ),
                //       Text(
                //         'Cold'.tr,
                //         style: TextStyle(
                //           fontSize: 12,
                //         ),
                //       ),
                //     ]),
                //     Row(children: [
                //       AbsorbPointer(
                //         absorbing: true,
                //         child: Checkbox(
                //           fillColor: MaterialStatePropertyAll(Colors.black),
                //           value: widget.freezing,
                //           onChanged: (bool? value) {},
                //         ),
                //       ),
                //       Text(
                //         'Freezing'.tr,
                //         style: TextStyle(
                //           fontSize: 12,
                //         ),
                //       ),
                //     ]),
                //   ],
                // ),
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
                  '${'space'.tr} :${widget.capacity} ${'M²'.tr}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('${'Total price'.tr} : ${widget.totalAmount} ${'SAR'.tr}',
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
              onPressed: isLoading
                  ? null
                  : () {
                      // final totalPrice = calculateTotalPrice();
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
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white,)
                  : Text(
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
