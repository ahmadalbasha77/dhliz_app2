import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../../../network/api_url.dart';
import 'Inventory_details.dart';
import 'add_stock_screen.dart';

class StockInventoryScreen extends StatefulWidget {
  int id;

  StockInventoryScreen({super.key, required this.id});

  @override
  State<StockInventoryScreen> createState() => _StockInventoryScreenState();
}

class _StockInventoryScreenState extends State<StockInventoryScreen> {
  List<Map<String, dynamic>> data = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        '${ApiUrl.API_BASE_URL}/Stock/Find?SubscriptionId=${widget.id}&PageIndex=0&PageSize=100'));

    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final responseData = jsonResponse['result']['response'][0];

      if (responseData != null) {
        setState(() {
          data = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Invalid response structure');
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
          'Stock Inventory'.tr,
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
              Container(
                margin: EdgeInsets.all(25),
                height: 60,
                width: 160,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black54)),
                    onPressed: () {
                      Get.off(() => AddStockScreen(
                            id: widget.id,
                          ));
                    },
                    child: Text("Add Item".tr)),
              )
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No Data'),
                              SizedBox(
                                height: 50,
                              ),
                              Text('Check your internet connection',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
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
                                          '${'space'.tr} : ${data[index]['capacity']} ',
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
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                InventoryDetailsScreen(
                                              data: data[index],
                                            ),
                                          ));
                                        },
                                        child: Text('Enter Stock'.tr,
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
