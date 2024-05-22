import 'package:dhliz_app/controllers/home/subscriptions_controllerl.dart';
import 'package:dhliz_app/view/new%20home/myWarehouse/stock_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../home/self mangement of invntory/warehouse management/add warehouse/add_warehouse_screen.dart';
import '../../home/self mangement of invntory/warehouse management/map_warehouse.dart';
import 'enter_inventory_new_screen.dart';

class EnterWarehouseScreen extends StatefulWidget {
  const EnterWarehouseScreen({super.key});

  @override
  State<EnterWarehouseScreen> createState() => _EnterWarehouseScreenState();
}

class _EnterWarehouseScreenState extends State<EnterWarehouseScreen> {
  final _controller = SubscriptionsController.to;

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
      body: GetBuilder<SubscriptionsController>(builder: (controller) {
        return controller.subscriptionsModel != null
            ? ListView.builder(
                itemCount: controller.subscriptionsModel!.response.length,
                itemBuilder: (context, index) {
                  _controller.subscriptionsDataModel =
                      _controller.subscriptionsModel!.response[index];
                  _controller.warehouse =
                      _controller.subscriptionsDataModel!.warehouse;
                  _controller.address = _controller.warehouse!.address;
                  _controller.price = _controller.warehouse!.price.first;
                  _controller.temperature = _controller.warehouse!.temperature;
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
                    child: InkWell(
                      onTap: () {
                        print(
                            _controller.subscriptionsModel!.response[index].id);
                        // _controller.subscriptionsModel!.response[index]
                        //             .status ==
                        //         0
                        //     ? Fluttertoast.showToast(
                        //         fontSize: 16, msg: 'subscription inactive'.tr)
                             Get.to(() => EnterInventoryNewScreen(
                                id: _controller
                                    .subscriptionsModel!.response[index].id
                                    .toString()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller
                                    .subscriptionsDataModel!.warehouse.name,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 35,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                          Color.fromRGBO(80, 46, 144, 1.0),
                                        )),
                                    onPressed: () {
                                      Get.to(MapWarehouseScreen(
                                        nameWh: _controller.subscriptionsModel!
                                            .response[index].warehouse.name,
                                        lat: double.parse(_controller
                                            .subscriptionsModel!
                                            .response[index]
                                            .warehouse
                                            .address
                                            .lat),
                                        lon: double.parse(_controller
                                            .subscriptionsModel!
                                            .response[index]
                                            .warehouse
                                            .address
                                            .lot),
                                      ));
                                    },
                                    child: Text(
                                      'View map'.tr,
                                      style: const TextStyle(fontSize: 12),
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              '${'Address'.tr} : ${_controller.address!.city} , ${_controller.address!.state} ,${_controller.address!.street}',
                              style: const TextStyle(
                                fontSize: 11,
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                                '${'Price'.tr} :  ${_controller.price!.cost} SAR / 1 M² per day',
                                style: const TextStyle(
                                  fontSize: 11,
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                                '${'Transportation Fees'.tr} : ${_controller.price!.transportationFees} SAR',
                                style: const TextStyle(
                                  fontSize: 11,
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                                '${'Subscription status'.tr} : ${_controller.subscriptionsDataModel!.status == 0 ? 'Under Review' : 'Active'} ',
                                style: const TextStyle(
                                  fontSize: 11,
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text('Temperature'.tr,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                AbsorbPointer(
                                  absorbing: true,
                                  child: Checkbox(
                                    fillColor: const MaterialStatePropertyAll(
                                        Colors.black),
                                    value: _controller.temperature!.dry,
                                    onChanged: (value) {},
                                  ),
                                ),
                                Text(
                                  'Dry'.tr,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ]),
                              Row(children: [
                                AbsorbPointer(
                                  absorbing: true,
                                  child: Checkbox(
                                    fillColor: const MaterialStatePropertyAll(
                                        Colors.black),
                                    value: _controller.temperature!.cold,
                                    onChanged: (bool? value) {},
                                  ),
                                ),
                                Text(
                                  'Cold'.tr,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ]),
                              Row(children: [
                                AbsorbPointer(
                                  absorbing: true,
                                  child: Checkbox(
                                    fillColor: const MaterialStatePropertyAll(
                                        Colors.black),
                                    value: _controller.temperature!.freezing,
                                    onChanged: (bool? value) {},
                                  ),
                                ),
                                Text(
                                  'Freezing'.tr,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          const Divider(height: .6, color: Colors.black),
                          // Row(
                          //   children: [
                          //     Text('Used'.tr,
                          //         style: TextStyle(
                          //             fontSize: 14, color: Colors.black54)),
                          //     LinearPercentIndicator(
                          //       barRadius: Radius.circular(15),
                          //       width: 250,
                          //       lineHeight: 14.0,
                          //       trailing: Text(
                          //         ((data[index]['warehouse']['spaceUsed'] /
                          //                         data[index]
                          //                             ['reservedSpace']) *
                          //                     100)
                          //                 .toStringAsFixed(2) +
                          //             '%', // Adjust the number of decimal places as needed
                          //       ),
                          //       percent: (data[index]['warehouse']
                          //                   ['spaceUsed'] /
                          //               data[index]['reservedSpace']) *
                          //           100,
                          //       backgroundColor: Colors.grey,
                          //       progressColor: Colors.black54,
                          //     ),
                          //     // Text(
                          //     //   '${data[index]['warehouse']['spaceUsed']}%',
                          //     //   style: TextStyle(
                          //     //       fontSize: 14,
                          //     //       fontWeight: FontWeight.bold),
                          //     // )
                          //   ],
                          // ),
                          Container(
                            margin: const EdgeInsets.only(top: 25),
                            child: Text(
                              '${'Reserved Space'.tr}: ${_controller.subscriptionsDataModel!.reservedSpace} ${'M²'.tr}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color.fromARGB(255, 35, 37, 56),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${'Expired WH'.tr}: ${_controller.subscriptionsDataModel!.endDate}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black54),
                              ),
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
                  );
                })
            : const Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }
}
