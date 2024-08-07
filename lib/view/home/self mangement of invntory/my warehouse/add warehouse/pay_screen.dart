import 'dart:convert';

import 'package:dhliz_app/view/home/self%20mangement%20of%20invntory/my%20warehouse/my_warehouse_screen.dart';
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
    if (response.statusCode == 200) {
      if (result['isSuccess'] == true) {
        Get.off(() => const MyWarehousesScreen());
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
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Subscription Details'.tr,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('${'Expired WH'.tr} : ${widget.to} ',
                      style: const TextStyle(color: Colors.black54, fontSize: 12)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.info.nameWarehouse,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('${'Address'.tr} : ${widget.info.address}',
                    style: const TextStyle(
                      fontSize: 12,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child:
                      Text('${'Price'.tr} : ${widget.cost}  ${'SAR/M²'.tr} ${'per day'.tr}',
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Text('${'Transportation Fees'.tr} : ${0} SAR ',
                //       style: TextStyle(
                //         fontSize: 12,
                //       )),
                // ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                      '${'Description inventory'.tr} : ${widget.inventoryDescription}  ',
                      style: const TextStyle(
                        fontSize: 12,
                      )),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('${"Temperature".tr} : ${widget.temp} ${'°C'.tr}',
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                const SizedBox(
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
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '${'space'.tr} :${widget.capacity} ${'M²'.tr}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('${'Total price'.tr} : ${widget.totalAmount} ${'SR'.tr}',
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 300,
            height: 55,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: const MaterialStatePropertyAll(0),
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
                  ? const CircularProgressIndicator(color: Colors.white,)
                  : Text(
                      'Send subscription request'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
