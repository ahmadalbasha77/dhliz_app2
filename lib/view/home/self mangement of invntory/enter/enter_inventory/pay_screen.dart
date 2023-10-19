import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'invoice_screen.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  List multipleSelected = [];
  List checkListItems = [
    {
      "id": 1,
      "value": true,
      "title": "Dry",
    },
    {
      "id": 2,
      "value": false,
      "title": "Cold",
    },
    {
      "id": 3,
      "value": false,
      "title": "Freezing",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Werehouse Information',
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
                  child: Text('Expired WH : 12/10/2023     30 Days',
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Werehouse 1',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Address : Jordan ,Amman',
                    style: TextStyle(
                      fontSize: 11,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('Price : 12 SAR / 1 M2 per month',
                      style: TextStyle(
                        fontSize: 11,
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text('Temperature',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 55,
                  child: GridView.builder(
                    physics: ScrollPhysics(parent: ScrollPhysics()),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 4.7),
                    itemCount: checkListItems.length,
                    itemBuilder: (context, index) => Container(
                        child: Row(children: [
                      AbsorbPointer(
                        absorbing: true,
                        child: Checkbox(
                          fillColor: MaterialStatePropertyAll(Colors.black),
                          value: checkListItems[index]['value'],
                          onChanged: (value) {
                            setState(() {
                              checkListItems[index]['value'] = value!;
                            });
                          },
                        ),
                      ),
                      Text(
                        checkListItems[index]['title'],
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ])),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text('Used',
                        style: TextStyle(fontSize: 14, color: Colors.black54)),
                    LinearPercentIndicator(
                      barRadius: Radius.circular(15),
                      width: 250,
                      lineHeight: 14.0,
                      percent: .0,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.black,
                    ),
                    Text(
                      '0%',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'spece :12 M²',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 80,
                ),
                Text('Total : 133/month',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          SizedBox(
            height: 110,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 300,
            height: 65,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStatePropertyAll(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(245, 211, 211, 211),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => InvoiceScreen(),
                ));
              },
              child: Text(
                'Pay now',
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
