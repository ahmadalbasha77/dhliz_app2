import 'package:dhliz_app/view/thank_you.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewDetailsWithdrawScreen extends StatefulWidget {
  const ViewDetailsWithdrawScreen({Key? key}) : super(key: key);

  @override
  State<ViewDetailsWithdrawScreen> createState() =>
      _ViewDetailsWithdrawScreenState();
}

class _ViewDetailsWithdrawScreenState extends State<ViewDetailsWithdrawScreen> {
  String? x;
  var selected;
  TextEditingController date = TextEditingController();

  void initState() {
    date.text = "";
    super.initState();
  }

  bool isSelectedOne = false;
  bool isSelectedOTwo = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('wh', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.04, horizontal: screenWidth * 0.05),
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.02,
                            horizontal: screenWidth * 0.03),
                        child: CircleAvatar(
                            backgroundImage:
                                AssetImage('image/dehliz/1633444786084.jpeg'),
                            radius: screenWidth * 0.12),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: screenWidth * 0.04,
                            left: screenWidth * 0.008,
                            bottom: screenWidth * 0.01),
                        child: Text('wh',
                            style: TextStyle(fontSize: screenWidth * 0.04)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.008),
                        child: Text('Stock ID : 10002',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: screenWidth * 0.024)),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: screenWidth * 0.02,
                            left: screenWidth * 0.008,
                            bottom: screenWidth * 0.015),
                        child: Text('aaaaaa',
                            style: TextStyle(color: Colors.black54)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.02,
                    horizontal: screenWidth * 0.05),
                child: Text(
                  'The space to be withdrawn',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 38, 50, 56),
                      fontWeight: FontWeight.w500),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                  decoration: InputDecoration(
                      suffixText: 'M²',
                      suffixStyle:
                          TextStyle(fontSize: 16, color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      label: Text('space',
                          style: TextStyle(color: Colors.black54)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.02,
                    horizontal: screenWidth * 0.05),
                child: Text(
                  'Withdrawal date',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 38, 50, 56),
                      fontWeight: FontWeight.w500),
                )),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: TextField(
                  readOnly: true,
                  controller: date,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        date.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_month_sharp),
                    filled: true,
                    fillColor: Colors.white,
                    label:
                        Text('date', style: TextStyle(color: Colors.black54)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'Default: Receive from warehouse',
                  style: TextStyle(fontSize: 16, color: Colors.black38),
                )),
            Container(
                margin: EdgeInsets.only(
                    top: screenWidth * 0.05, left: screenWidth * 0.05),
                child: Text(
                  'Other services',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 38, 50, 56),
                      fontWeight: FontWeight.w500),
                )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(children: [
                  Checkbox(
                    value: isSelectedOne,
                    onChanged: (value) {
                      setState(() {
                        isSelectedOne = !isSelectedOne;
                      });
                    },
                  ),
                  Text(
                    'With delivery to a new location',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ])),
            if (isSelectedOne == true)
              Container(
                alignment: Alignment.center,
                height: 35,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 38, 50, 56),
                        )),
                    onPressed: () {},
                    child: Text(
                      'Select a delivery location',
                      style: TextStyle(fontSize: 12),
                    )),
              ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(children: [
                  Checkbox(
                    value: isSelectedOTwo,
                    onChanged: (value) {
                      setState(() {
                        isSelectedOTwo = !isSelectedOTwo;
                      });
                    },
                  ),
                  Text(
                    'With packaging',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ])),
            SizedBox(
              height: isSelectedOne ? 10 : 45,
            ),
            Center(
              child: Container(
                width: 270,
                height: 60,
                margin: EdgeInsets.only(top: 25),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 38, 50, 56)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      Get.off(ThankYouScreen());
                    },
                    child: const Text('Withdraw Now')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
