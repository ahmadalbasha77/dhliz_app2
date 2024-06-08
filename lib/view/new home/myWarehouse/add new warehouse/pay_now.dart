import 'package:dhliz_app/view/home/self%20mangement%20of%20invntory/warehouse%20management/add%20warehouse/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/app_color.dart';

import '../../../../models/home/subscriptions_model.dart';

class PayNowScreen extends StatefulWidget {
  final SubscriptionsDataModel? subscriptionsDataModel;
  final Warehouse? warehouse;
  final Address? address;
  final Price? price;

  const PayNowScreen({
    super.key,
    required this.subscriptionsDataModel,
    required this.warehouse,
    required this.address,
    required this.price,
  });

  @override
  State<PayNowScreen> createState() => _PayNowScreenState();
}

class _PayNowScreenState extends State<PayNowScreen> {
  int calculateTotalPrice() {
    return int.parse(
        (((widget.price!.cost * widget.subscriptionsDataModel!.reservedSpace) +
                    widget.price!.transportationFees)
                .round())
            .toString());
  }

  @override
  void initState() {
    super.initState();

    print('==============================');
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = calculateTotalPrice();
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
                  child: Text(
                      '${'Expired WH'.tr} : ${widget.subscriptionsDataModel!.endDate} ',
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.warehouse!.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('${'Address'.tr} : ${widget.address!.city}',
                    style: TextStyle(
                      fontSize: 11,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                      '${'Price'.tr} : ${widget.price!.cost} SAR / 1 M2 per day',
                      style: TextStyle(
                        fontSize: 11,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                      '${'Transportation Fees'.tr} : ${widget.price!.transportationFees} SAR ',
                      style: TextStyle(
                        fontSize: 11,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 5),
                //   child: Text('${"Temperature".tr}',
                //       style:
                //           TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                // ),
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
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${'space'.tr} :${widget.subscriptionsDataModel!.reservedSpace} ${'M²'.tr}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('${'Total price'.tr} : $totalPrice ${'SR'.tr}',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          SizedBox(
            height: 150,
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
                Get.off(() => PaymentScreen(
                      totalAmount: totalPrice,
                      subscriptionsDataModel: widget.subscriptionsDataModel,
                      address: widget.address,
                      warehouse: widget.warehouse,
                    ));
              },
              child: Text(
                'Pay Now'.tr,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
