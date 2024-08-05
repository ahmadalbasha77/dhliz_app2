import 'dart:convert';

import 'package:dhliz_app/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/shared_prefs_client.dart';
import '../../../../network/api_url.dart';
import '../warehouse management/map_warehouse.dart';
import 'withdrawal_of_inventory_screen.dart';

class WithdrawWarehouseScreen extends StatefulWidget {
  const WithdrawWarehouseScreen({super.key});

  @override
  State<WithdrawWarehouseScreen> createState() =>
      _WithdrawWarehouseScreenState();
}

class _WithdrawWarehouseScreenState extends State<WithdrawWarehouseScreen> {
  List<Map<String, dynamic>> data = [];

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('postId');

    final response = await http.get(
        Uri.parse(
            '${ApiUrl.API_BASE_URL}/Customer/GetSupscriptionByCustomerId?id=${sharedPrefsClient.customerId}'),
        headers: {'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'});

    if (response.statusCode == 200) {
      setState(() {
        data = List<Map<String, dynamic>>.from(
            json.decode(response.body)['response'][0]);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text('Withdraw Warehouse',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: data.isEmpty
                ? FutureBuilder(
                    future: Future.delayed(Duration(seconds: 3)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Center(
                          child:
                              Text('No Data', style: TextStyle(fontSize: 16)),
                        );
                      }
                    },
                  )
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WithdrawalOfInventoryScreen(
                              id: data[index]['id'],
                            ),
                          ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data[index]['warehouse']['name'],
                                  style: TextStyle(
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
                                              MaterialStatePropertyAll(
                                            AppColor.buttonColor,
                                          )),
                                      onPressed: () {
                                        Get.to(() => MapWarehouseScreen(
                                            nameWh: data[index]['warehouse']
                                                ['name'],
                                            lat: double.parse(data[index]
                                                    ['warehouse']['address']
                                                ['lat']),
                                            lon: double.parse(data[index]
                                                    ['warehouse']['address']
                                                ['lot'])));
                                      },
                                      child: Text(
                                        'View map'.tr,
                                        style: TextStyle(fontSize: 12),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                '${'Address'.tr} : ${data[index]['warehouse']['address']['city']} , ${data[index]['warehouse']['address']['state']} , ${data[index]['warehouse']['address']['street']} ',
                                style: TextStyle(
                                  fontSize: 11,
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                  '${'Price'.tr} : ${data[index]['warehouse']['price'][0]['cost'].toString()}  SAR / 1 M² per day',
                                  style: TextStyle(
                                    fontSize: 11,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                  '${'Transportation Fees'.tr} : ${data[index]['warehouse']['price'][0]['transportationFees'].toString()}  SAR',
                                  style: TextStyle(
                                    fontSize: 11,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text('Temperature'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Row(children: [
                                  AbsorbPointer(
                                    absorbing: true,
                                    child: Checkbox(
                                      fillColor: MaterialStatePropertyAll(
                                          Colors.black),
                                      value: data[index]['warehouse']
                                          ['temperature']['high'],
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
                                      fillColor: MaterialStatePropertyAll(
                                          Colors.black),
                                      value: data[index]['warehouse']
                                          ['temperature']['cold'],
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
                                      fillColor: MaterialStatePropertyAll(
                                          Colors.black),
                                      value: data[index]['warehouse']
                                          ['temperature']['freezing'],
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
                            // Row(
                            //   children: [
                            //     Text('Used'.tr,
                            //         style: TextStyle(
                            //             fontSize: 14, color: Colors.black54)),
                            //     LinearPercentIndicator(
                            //       barRadius: Radius.circular(15),
                            //       width: 250,
                            //       lineHeight: 14.0,
                            //       percent: data[index]['warehouse']
                            //               ['spaceUsed'] /
                            //           100,
                            //       backgroundColor: Colors.grey,
                            //       progressColor: Colors.black54,
                            //     ),
                            //     Text(
                            //       '20%',
                            //       style: TextStyle(
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.bold),
                            //     )
                            //   ],
                            // ),
                            Divider(height: .6, color: Colors.black),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              '${'Reserved Space'.tr} : ${data[index]['reservedSpace'].toString()} M²',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color.fromARGB(255, 35, 37, 56),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${'Expired WH'.tr} : ${data[index]['endDate'].toString()}  ',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
