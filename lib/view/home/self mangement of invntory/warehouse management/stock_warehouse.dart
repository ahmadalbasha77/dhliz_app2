import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../../../config/shared_prefs_client.dart';
import '../../../../network/api_url.dart';
import 'stock_details.dart';

class StockWarehouse extends StatefulWidget {
  int id;

  StockWarehouse({super.key, required this.id});

  @override
  State<StockWarehouse> createState() => _StockWarehouseState();
}

class _StockWarehouseState extends State<StockWarehouse> {
  List<Map<String, dynamic>> data = [];

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse(
            '${ApiUrl.API_BASE_URL}/Stock/Find?SubscriptionId=${widget.id}&PageIndex=0&PageSize=100'),
        headers: {'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'});


    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final responseData = jsonResponse['result']['response'][0];

      if (responseData != null) {
        setState(() {
          data = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
      }
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
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Stock Warehouse'.tr,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(25),
                child: Icon(Icons.filter_list, size: 30),
              ),
            ],
          ),
          Expanded(
            child: data.isEmpty
                ? FutureBuilder(
                    future: Future.delayed(Duration(seconds: 3)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Center(
                          child: Text('No Data'),
                        );
                      }
                    },
                  )
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Text(data[index]['name'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        child: Text(
                                          '${'space'.tr}: ${data[index]['capacity']} ',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13),
                                        )),
                                    Container(
                                        child: Text(
                                      '${'Stock ID'.tr} : ${data[index]['id']}',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                    )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(StockDetails(
                                            data: data[index],
                                          ));
                                        },
                                        child: Text('View Details'.tr,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      Image.file(File(data[index]['photo']))
                                          .image),
                              width: 110,
                            )
                          ],
                        )),
                  ),
          ),
        ],
      ),
    );
  }
}
