import 'package:dhliz_app/controllers/home/subscriptions_controllerl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../models/home/subscriptions_model.dart';
import '../../../widgets/src/pagination_exception.dart';
import '../../home/self mangement of invntory/warehouse management/map_warehouse.dart';
import '../myWarehouse/add new warehouse/pay_now.dart';
import 'enter_inventory_new_screen.dart';

class EnterWarehouseScreen extends StatefulWidget {
  const EnterWarehouseScreen({super.key});

  @override
  State<EnterWarehouseScreen> createState() => _EnterWarehouseScreenState();
}

class _EnterWarehouseScreenState extends State<EnterWarehouseScreen> {
  final _controller = SubscriptionController.to;

  @override
  void initState() {
    _controller.pagingController.addPageRequestListener((pageKey) {
      _controller.getSubscription(pageKey: pageKey);
    });

    _controller.refreshPagingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Enter Warehouse'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: PagedListView<int, SubscriptionDataModel>(
            pagingController: _controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<SubscriptionDataModel>(
              noItemsFoundIndicatorBuilder: (context) => PaginationException(
                title: 'No items found'.tr,
                message: 'The list is currently empty.'.tr,
              ),
              itemBuilder: (context, item, index) => Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: InkWell(
                  onTap: () {
                    item.status == 1
                        ? Get.to(() =>
                            EnterInventoryNewScreen(id: item.id.toString()))
                        : Fluttertoast.showToast(
                            fontSize: 16, msg: 'subscription inactive'.tr);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.warehouse.name,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 35,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                15))),
                                    backgroundColor:
                                    const MaterialStatePropertyAll(
                                      Color.fromRGBO(
                                          80, 46, 144, 1.0),
                                    )),
                                onPressed: () {
                                  Get.to(MapWarehouseScreen(
                                    nameWh: item.warehouse.name,
                                    lat: double.parse(
                                        item.address.lat),
                                    lon: double.parse(
                                        item.address.lot),
                                  ));
                                },
                                child: Text(
                                  'View map'.tr,
                                  style:
                                  const TextStyle(fontSize: 12),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          '${'Address'.tr} : ${item.address.city} , ${item.address.state} ,${item.address.street}',
                          style: const TextStyle(
                            fontSize: 11,
                          )),
                      // Container(
                      //   margin:
                      //       const EdgeInsets.symmetric(vertical: 5),
                      //   child: Text(
                      //       '${'Price'.tr} :  ${item.warehouse.price.first.cost} SAR / 1 M² per day',
                      //       style: const TextStyle(
                      //         fontSize: 11,
                      //       )),
                      // ),
                      // Container(
                      //   margin:
                      //       const EdgeInsets.symmetric(vertical: 5),
                      //   child: Text(
                      //       '${'Transportation Fees'.tr} : ${item.warehouse.price.first.transportationFees} SAR',
                      //       style: const TextStyle(
                      //         fontSize: 11,
                      //       )),
                      // ),
                      Container(
                        margin:
                        const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                            '${'Subscription status'.tr} : ${item.status == 0 ? 'Under Review' : item.status == 1 ? 'Accepted' : item.status == 2 ? 'Rejected' : item.status == 3 ? 'PreliminaryApproval' : 'Error'} ',
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
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: item.status == 1
                                      ? Colors.green
                                      : Colors.red)),
                          child: Text(
                              '${'Payment status'.tr} : ${item.status == 1 ? 'Paid' : 'UnPaid'} ',
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
                          'Temperature : ${item.temperature.fromTemperature} - ${item.temperature.toTemperature} °C'
                              .tr,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Cost : ${item.temperature.cost}  SAR/M2'
                              .tr,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      // Row(
                      //   mainAxisAlignment:
                      //       MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(children: [
                      //       AbsorbPointer(
                      //         absorbing: true,
                      //         child: Checkbox(
                      //           fillColor:
                      //               const MaterialStatePropertyAll(
                      //                   Colors.black),
                      //           value: _controller.temperature!.dry,
                      //           onChanged: (value) {},
                      //         ),
                      //       ),
                      //       Text(
                      //         'Dry'.tr,
                      //         style: const TextStyle(
                      //           fontSize: 12,
                      //         ),
                      //       ),
                      //     ]),
                      //     Row(children: [
                      //       AbsorbPointer(
                      //         absorbing: true,
                      //         child: Checkbox(
                      //           fillColor:
                      //               const MaterialStatePropertyAll(
                      //                   Colors.black),
                      //           value: _controller.temperature!.cold,
                      //           onChanged: (bool? value) {},
                      //         ),
                      //       ),
                      //       Text(
                      //         'Cold'.tr,
                      //         style: const TextStyle(
                      //           fontSize: 12,
                      //         ),
                      //       ),
                      //     ]),
                      //     Row(children: [
                      //       AbsorbPointer(
                      //         absorbing: true,
                      //         child: Checkbox(
                      //           fillColor:
                      //               const MaterialStatePropertyAll(
                      //                   Colors.black),
                      //           value:
                      //               _controller.temperature!.freezing,
                      //           onChanged: (bool? value) {},
                      //         ),
                      //       ),
                      //       Text(
                      //         'Freezing'.tr,
                      //         style: const TextStyle(
                      //           fontSize: 12,
                      //         ),
                      //       ),
                      //     ]),
                      //   ],
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text('Used'.tr,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54)),
                          LinearPercentIndicator(
                            barRadius: Radius.circular(15),
                            width: 190.w,
                            lineHeight: 14.0,
                            trailing: Text(
                              ((item.spaceUsed / item.reservedSpace) *
                                  100)
                                  .toStringAsFixed(1) +
                                  '%', // Adjust the number of decimal places as needed
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
                          Text(
                            '${'Expired WH'.tr}: ${item.endDate}',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black54),
                          ),
                          item.status == 3
                              ? Container(
                            margin: EdgeInsets.symmetric(
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
                              : Container()
                          // SizedBox(
                          //   height: 30,
                          //   child: ElevatedButton(
                          //       style: ButtonStyle(
                          //           shape: MaterialStatePropertyAll(
                          //               RoundedRectangleBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(
                          //                           10))),
                          //           backgroundColor:
                          //               MaterialStatePropertyAll(
                          //             Color.fromARGB(255, 253, 191, 8),
                          //           )),
                          //       onPressed: () {
                          //         Get.off(ThankYouScreen());
                          //       },
                          //       child: Text(
                          //         'Upgrade Space'.tr,
                          //         style: TextStyle(fontSize: 10),
                          //       )),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
