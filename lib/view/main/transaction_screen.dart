import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:http/http.dart' as http;

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
      final response = await http.get(Uri.parse(
          '${ApiUrl.API_BASE_URL}/Transaction/GetAllTransaction'));

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: Text('Transaction', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: screenSize.width * .05,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('Enter inventory',
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('150', style: TextStyle(fontSize: 27)),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .005),
                        child: Container(
                          padding: EdgeInsets.all(screenSize.height * .005),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * .03),
                              child: Text('Enters',
                                  style: TextStyle(color: Colors.green[300])),
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
                      child: Text('Withdrawal  ',
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('170', style: TextStyle(fontSize: 27)),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .005),
                        child: Container(
                          padding: EdgeInsets.all(screenSize.height * .005),
                          decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * .02),
                              child: Text('Withdrawals',
                                  style: TextStyle(color: Colors.red[400])),
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
                      child: Text('Transfer ',
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .005),
                      child: Text('4', style: TextStyle(fontSize: 27)),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .005),
                        child: Container(
                          padding: EdgeInsets.all(screenSize.height * .005),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * .03),
                              child: Text('Transfer',
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
                left: screenSize.width * .06, bottom: screenSize.height * .015),
            alignment: Alignment.topLeft,
            child: Text('All Transactions', style: TextStyle(fontSize: 22)),
          ),
          Expanded(
            child: data.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => Container(
                          alignment: Alignment.topLeft,
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenSize.height * .012,
                                            horizontal: screenSize.width * .03),
                                        child: Text(data[index]['stockName'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenSize.height * .012,
                                            horizontal:
                                                screenSize.width * .025),
                                        child: Text('Date : 12/10 ',
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: screenSize.width * .028,
                                            vertical: screenSize.height * .012),
                                        child: Text('time :  11:30 ',
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * .05),
                                    child: Text(
                                        'Transaction ID : ${data[index]['transactionId']}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * .05,
                                        vertical: screenSize.width * .03),
                                    child: Text(
                                        'Quantity withdrawn : ${data[index]['quantity']}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * .05),
                                    child: TextButton.icon(
                                        onPressed: () {
                                          Share.share(
                                            '\n\nname item :  \n\n Transactions Id :  \n\n '
                                            'Date : '
                                            '  time : }',
                                          );
                                        },
                                        icon: Icon(Icons.share,
                                            color: Colors.black),
                                        label: Text(
                                          'Share',
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        data[index]['actionType'] == 0
                                            ? 'Withdrawal'
                                            : data[index]['actionType'] == 1
                                                ? 'Enter'
                                                : 'Transfer',
                                        style: TextStyle(color: Colors.black54),
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
