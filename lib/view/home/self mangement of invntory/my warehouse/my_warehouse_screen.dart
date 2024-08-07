import 'package:dhliz_app/controllers/home/subscriptions_controllerl.dart';
import 'package:dhliz_app/view/home/self%20mangement%20of%20invntory/my%20warehouse/stock_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../models/home/subscriptions_model.dart';
import '../../../../widgets/src/pagination_exception.dart';
import 'add warehouse/add_warehouse_screen.dart';
import 'map_warehouse.dart';
import 'pay_now.dart';

class MyWarehousesScreen extends StatefulWidget {
  const MyWarehousesScreen({super.key});

  @override
  State<MyWarehousesScreen> createState() => _MyWarehousesScreenState();
}

class _MyWarehousesScreenState extends State<MyWarehousesScreen> {
  final _controller = SubscriptionController.to;

  @override
  void initState() {
    super.initState();
    _controller.pagingController.addPageRequestListener((pageKey) {
      _controller.getSubscription(pageKey: pageKey);
    });

    _controller.refreshPagingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'My Warehouse'.tr,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    backgroundColor: const MaterialStatePropertyAll(
                      Color.fromRGBO(80, 46, 144, 1.0),
                    )),
                onPressed: () {
                  Get.off(() => const AddWarehouseScreen());
                },
                child: Text(
                  'Add Warehouse'.tr,
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                )),
          ),
          Expanded(
              child: PagedListView<int, SubscriptionDataModel>(
                  pagingController: _controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<
                          SubscriptionDataModel>(
                      noItemsFoundIndicatorBuilder: (context) =>
                          PaginationException(
                            title: 'No items found'.tr,
                            message: 'The list is currently empty'.tr,
                          ),
                      itemBuilder: (context, item, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 12.h),
                          child: InkWell(
                            onTap: () {
                              item.status == 1
                                  ? Get.to(() =>
                                      StockNewScreen(id: item.id.toString()))
                                  : Fluttertoast.showToast(
                                      fontSize: 16,
                                      msg: 'subscription inactive'.tr);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.warehouse.name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                              Color.fromRGBO(80, 46, 144, 1.0),
                                            )),
                                        onPressed: () {
                                          Get.to(() => MapWarehouseScreen(
                                                nameWh: item.warehouse.name,
                                                lat: double.parse(
                                                    item.address.lat),
                                                lon: double.parse(
                                                    item.address.lot),
                                              ));
                                        },
                                        child: Text(
                                          'View map'.tr,
                                          style: const TextStyle(fontSize: 12),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                    '${'Address'.tr} : ${item.address.city} , ${item.address.state} ,${item.address.street}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    )),

                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                      '${'Subscription status'.tr} : ${item.status == 0 ? 'Under Review'.tr : item.status == 1 ? 'Accepted'.tr : item.status == 2 ? 'Rejected'.tr : item.status == 3 ? 'PreliminaryApproval'.tr : 'Error'.tr} ',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: item.status == 0
                                              ? Colors.orange
                                              : item.status == 2
                                                  ? Colors.red
                                                  : Colors.green)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (item.status == 1 || item.status == 3)
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: item.status == 1
                                                ? Colors.green
                                                : Colors.red)),
                                    child: Text(
                                        '${'Payment status'.tr} : ${item.status == 1 ? 'Paid'.tr : 'UnPaid'.tr} ',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: item.status == 1
                                                ? Colors.green
                                                : Colors.red)),
                                  ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    '${'Temperature'.tr} : ${item.temperature.fromTemperature} - ${item.temperature.toTemperature} ${'°C'.tr}'
                                        .tr,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    '${'Cost'.tr} : ${item.temperature.cost}  ${'SAR/M2'.tr}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),

                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text('Used'.tr,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54)),
                                    LinearPercentIndicator(
                                      barRadius: const Radius.circular(15),
                                      width: 190.w,
                                      lineHeight: 14.0,
                                      trailing: Text(
                                        '${((item.spaceUsed / item.reservedSpace) * 100).toStringAsFixed(1)}%', // Adjust the number of decimal places as needed
                                      ),
                                      // percent: (item.spaceUsed /
                                      //     item.reservedSpace) *
                                      //     100,
                                      backgroundColor: Colors.grey,
                                      progressColor: Colors.black54,
                                    ),
                                    // Text(
                                    //   '${data[index]['warehouse']['spaceUsed']}%',
                                    //   style: TextStyle(
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.bold),
                                    // )
                                  ],
                                ),
                                // const Divider(height: .6, color: Colors.black),

                                Container(
                                  margin: const EdgeInsets.only(top: 25),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${'Reserved Space'.tr}: ${item.reservedSpace} ${'M²'.tr}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 35, 37, 56),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${'Expired WH'.tr}: ${item.endDate}',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      ),
                                    ),
                                    item.status == 3
                                        ? Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.green[600]),
                                              ),
                                              onPressed: () {
                                                Get.to(() => PayNowScreen(
                                                      data: item,
                                                    ));
                                              },
                                              child: Text('Pay Now'.tr),
                                            ),
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                ),
                              ],
                            ),
                          ))))),
        ],
      ),
    );
  }
}
