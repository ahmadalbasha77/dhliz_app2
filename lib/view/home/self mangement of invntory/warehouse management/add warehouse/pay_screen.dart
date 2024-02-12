import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;

import '../../../../../config/shared_prefs_client.dart';
import '../../../../../network/api_url.dart';
import 'payment_screen.dart';
import 'invoice_screen.dart';

class PayScreen extends StatefulWidget {
  int customerId;
  String warehouseId;
  String warehouseName;
  String expiredDate;
  String address;
  int capacity;
  double price;
  String space;
  String from;
  String to;
  bool dry;
  bool cold;
  bool freezing;

  PayScreen({
    super.key,
    required this.customerId,
    required this.warehouseId,
    required this.warehouseName,
    required this.capacity,
    required this.expiredDate,
    required this.address,
    required this.price,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Warehouse Information'.tr,
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
                  child: Text(
                      '${'Price'.tr} : ${widget.price} SAR / 1 M2 per month',
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
                Row(
                  children: [
                    Text('${'Used'.tr}',
                        style: TextStyle(fontSize: 14, color: Colors.black54)),
                    LinearPercentIndicator(
                      barRadius: Radius.circular(15),
                      width: 250,
                      lineHeight: 14.0,
                      percent: .0,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.black,
                    ),
                    Text(
                      '0%',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${'space'.tr} :${widget.space} ${'M²'.tr}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                    '${'Total price'.tr} : ${widget.price * widget.capacity} ${'SR'.tr}',
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
                  Color.fromARGB(255, 35, 37, 56),
                ),
              ),
              onPressed: () {
                final totalPrice = calculateTotalPrice();
                // postData();
                Get.off(PaymentScreen(
                  amount: totalPrice,
                  customerId: 4,
                  capacity: widget.capacity,
                  warehouseId: widget.warehouseId,
                ));
              },
              child: Text(
                'Pay now'.tr,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
