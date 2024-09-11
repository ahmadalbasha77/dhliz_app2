import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/app_color.dart';

import '../../../../models/home/subscriptions_model.dart';
import 'add warehouse/payment_screen.dart';

class PayNowScreen extends StatefulWidget {
  final SubscriptionDataModel? data;

  const PayNowScreen({
    super.key,
    required this.data,
  });

  @override
  State<PayNowScreen> createState() => _PayNowScreenState();
}

class _PayNowScreenState extends State<PayNowScreen> {
  int calculateTotalPrice() {
    // Parse the start and end dates from strings to DateTime
    DateTime startDate = DateTime.parse(widget.data!.startDate);
    DateTime endDate = DateTime.parse(widget.data!.endDate);

    // Calculate the number of days between the two dates
    int days = endDate.difference(startDate).inDays;
    log('$days');
    // Calculate the total price and return it as an integer
    return int.parse(
        (((widget.data!.temperature.cost * widget.data!.reservedSpace) * days)
                .round())
            .toString());
  }

  @override
  void initState() {
    log('*******************************');
    log(widget.data!.temperature.cost.toString());
    log(widget.data!.reservedSpace.toString());
    log(widget.data!.endDate.toString());
    log(widget.data!.startDate.toString());
    log('*******************************');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = calculateTotalPrice();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
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
                  child: Text('${'Expired WH'.tr} : ${widget.data!.endDate} ',
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.data!.warehouse.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('${'Address'.tr} : ${widget.data!.address.city}',
                    style: const TextStyle(
                      fontSize: 11,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                      '${'Price'.tr} : ${widget.data!.temperature.cost} SAR / 1 M2 per day',
                      style: const TextStyle(
                        fontSize: 11,
                      )),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Text(
                //       '${'Transportation Fees'.tr} : ${widget.price!.transportationFees} SAR ',
                //       style: TextStyle(
                //         fontSize: 11,
                //       )),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "Temperature ${widget.data!.temperature.fromTemperature} - ${widget.data!.temperature.toTemperature} C"
                          .tr,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),

                const SizedBox(
                  height: 20,
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
                  '${'space'.tr} :${widget.data!.reservedSpace} ${'M²'.tr}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text('${'Total price'.tr} : $totalPrice ${'SR'.tr}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(
            height: 150,
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
              onPressed: () {
                Get.off(() => PaymentScreen(
                      totalAmount: totalPrice,
                      data: widget.data,
                    ));
              },
              child: Text(
                'Pay Now'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
