import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'package:http/http.dart' as http;
import '../../config/shared_prefs_client.dart';
import '../../network/api_url.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Map<String, dynamic>> data = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse(
              '${ApiUrl.API_BASE_URL}/Transaction/GetAllTransaction?CustomerName=${sharedPrefsClient.fullName}&PageIndex=0&PageSize=100'),
          headers: {
            'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
          });

      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('response')) {
          final responseData = jsonResponse['response'];

          if (responseData.isNotEmpty) {
            setState(() {
              data = List<Map<String, dynamic>>.from(responseData[0]);
            });
          } else {
            print('Empty response array');
          }
        } else {
          print('Invalid response structure: Missing "response" key');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    fetchData();
    print('****************************************');
    print(sharedPrefsClient.accessToken);
    print('****************************************');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int countWithdraw = data.where((item) => item['actionType'] == 0).length;
    int countEnter = data.where((item) => item['actionType'] == 1).length;
    int countTransfer = data.where((item) => item['actionType'] == 2).length;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: Text('Transactions'.tr, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: data.isEmpty
          ? FutureBuilder(
              future: Future.delayed(Duration(seconds: 7)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(color: Colors.red[700], fontSize: 18),
                    ),
                  );
                }
              },
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(
                      //   left: screenSize.width * .05,
                      //   right: screenSize.width * .05,
                      // ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * .005),
                            child: Text('Enter inventory'.tr,
                                style: TextStyle(color: Colors.black54)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * .005),
                            child: Text(countEnter.toString(),
                                style: TextStyle(fontSize: 27)),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * .005),
                              child: Container(
                                padding:
                                    EdgeInsets.all(screenSize.height * .005),
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Row(children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * .03),
                                    child: Text('Enters'.tr,
                                        style: TextStyle(
                                            color: Colors.green[300])),
                                  ),
                                  Icon(
                                    Icons.call_made_outlined,
                                    color: Colors.green,
                                    size: screenSize.height * .015,
                                  )
                                ]),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenSize.width * .005,
                          vertical: screenSize.height * .018),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * .005),
                            child: Text('Withdrawal'.tr,
                                style: TextStyle(color: Colors.black54)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * .005),
                            child: Text(countWithdraw.toString(),
                                style: TextStyle(fontSize: 27)),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * .005),
                              child: Container(
                                padding:
                                    EdgeInsets.all(screenSize.height * .005),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Row(children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * .02),
                                    child: Text('Withdrawals'.tr,
                                        style:
                                            TextStyle(color: Colors.red[400])),
                                  ),
                                  Icon(
                                    Icons.call_received,
                                    color: Colors.red,
                                    size: screenSize.height * .015,
                                  )
                                ]),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * .005),
                            child: Text('Transfer'.tr,
                                style: TextStyle(color: Colors.black54)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * .005),
                            child: Text(countTransfer.toString(),
                                style: TextStyle(fontSize: 27)),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * .005),
                              child: Container(
                                padding:
                                    EdgeInsets.all(screenSize.height * .005),
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Row(children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * .03),
                                    child: Text('Transfer'.tr,
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Icon(
                                    Icons.moving,
                                    color: Colors.green,
                                    size: screenSize.height * .015,
                                  )
                                ]),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenSize.width * .06,
                      right: screenSize.width * .06,
                      bottom: screenSize.height * .015),
                  child: Text('All Transactions'.tr,
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.start),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.symmetric(
                                horizontal: 13, vertical: 6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical:
                                                  screenSize.height * .012,
                                              horizontal:
                                                  screenSize.width * .03),
                                          child: Text(data[index]['stockName'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        // Container(
                                        //   margin: EdgeInsets.symmetric(
                                        //       vertical:
                                        //           screenSize.height * .012,
                                        //       horizontal:
                                        //           screenSize.width * .18),
                                        //   child: Text('${'Date'.tr} : 12/10 ',
                                        //       style: TextStyle(
                                        //           color: Colors.black38,
                                        //           fontSize: 12,
                                        //           fontWeight: FontWeight.w500)),
                                        // ),
                                        // Container(
                                        //   margin: EdgeInsets.symmetric(
                                        //       horizontal:
                                        //           screenSize.width * .028,
                                        //       vertical:
                                        //           screenSize.height * .012),
                                        //   child: Text('time :  11:30 ',
                                        //       style: TextStyle(
                                        //           color: Colors.black26,
                                        //           fontSize: 12,
                                        //           fontWeight: FontWeight.w500)),
                                        // ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * .05),
                                      child: Text(
                                          '${'Transaction ID'.tr} : ${data[index]['transactionId']}',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13)),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.width * .05,
                                              vertical: screenSize.width * .03),
                                          child: Text(
                                              '${'Quantity'.tr}  : ${data[index]['quantity']}',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 13)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.width * .05,
                                              vertical: screenSize.width * .03),
                                          child: Row(
                                            children: [
                                              Text(
                                                  data[index]['status'] == 0
                                                      ? 'Under Review'.tr
                                                      : data[index]['status'] ==
                                                              1
                                                          ? 'Accepted'.tr
                                                          : 'Rejected'.tr,
                                                  style: TextStyle(
                                                      color: data[index]
                                                                  ['status'] ==
                                                              0
                                                          ? Colors.amber
                                                          : data[index][
                                                                      'status'] ==
                                                                  1
                                                              ? Colors.green
                                                              : Colors.red,
                                                      fontSize: 13)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                data[index]['status'] == 0
                                                    ? Icons.pending
                                                    : data[index]['status'] == 1
                                                        ? Icons
                                                            .check_circle_outline
                                                        : Icons.cancel_outlined,
                                                color: data[index]['status'] ==
                                                        0
                                                    ? Colors.amber
                                                    : data[index]['status'] == 1
                                                        ? Colors.green
                                                        : Colors.red,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: screenSize.width * .05),
                                      child: TextButton.icon(
                                          onPressed: () {
                                            Share.share(
                                              'Transactions Details  \n\nName Item : ${data[index]['stockName']}   \n\n Transactions Id :${data[index]['transactionId']}  \n\n '
                                              'quantity : ${data[index]['quantity']} \n\n status :  ${data[index]['status'] == 0 ? 'Under Review'.tr : data[index]['status'] == 1 ? 'Accepted'.tr : 'Rejected'.tr}'
                                              '  ',
                                            );
                                          },
                                          icon: Icon(Icons.share,
                                              color: Colors.black),
                                          label: Text(
                                            'Share'.tr,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          )),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        child: data[index]['actionType'] == 0
                                            ? Icon(Icons.call_received,
                                                color: Colors.red)
                                            : data[index]['actionType'] == 1
                                                ? Icon(Icons.call_made_outlined,
                                                    color: Colors.green)
                                                : Icon(Icons.moving,
                                                    color: Colors.green)),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          data[index]['actionType'] == 0
                                              ? 'Withdrawal'.tr
                                              : data[index]['actionType'] == 1
                                                  ? 'Enter'.tr
                                                  : 'Transfer'.tr,
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          )),
                ),
              ],
            ),
    );
  }
}
