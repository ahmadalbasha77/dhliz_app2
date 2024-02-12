import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../config/shared_prefs_client.dart';
import '../../../../network/api_url.dart';
import 'view_details._withdraw_screen.dart';

class WithdrawalOfInventoryScreen extends StatefulWidget {
  int id;

  WithdrawalOfInventoryScreen({super.key, required this.id});

  @override
  State<WithdrawalOfInventoryScreen> createState() =>
      _WithdrawalOfInventoryScreenState();
}

class _WithdrawalOfInventoryScreenState
    extends State<WithdrawalOfInventoryScreen> {
  List<Map<String, dynamic>> data = [];

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse(
            '${ApiUrl.API_BASE_URL}/Stock/Find?SubscriptionId=${widget.id}'),
        headers: {'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'});

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
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text('Withdrawal of invntory',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
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
                                            color: Colors.black54,
                                            fontSize: 13),
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
                                                  ViewDetailsWithdrawScreen(
                                                id: data[index]['id'],
                                                nameWarehouse: data[index]
                                                    ['name'],
                                                desWarehouse: data[index]
                                                    ['description'],
                                                image: data[index]['photo'],
                                              ),
                                            ));
                                          },
                                          child: Text('Stock withdrawal'.tr,
                                              style: TextStyle(
                                                  color: Colors.black)),
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
                            ])),
                  ),
          ),
        ],
      ),
    );
  }
}
