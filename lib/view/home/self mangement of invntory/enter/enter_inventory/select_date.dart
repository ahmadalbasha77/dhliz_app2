import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'select_stock_type.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  String dateDifference = "";

  @override
  void initState() {
    from.text = "";
    to.text = "";
    dateDifference = "";
    super.initState();
  }

  void updateDateDifference() {
    if (from.text.isNotEmpty && to.text.isNotEmpty) {
      DateTime fromDate = DateFormat('yyyy-MM-dd').parse(from.text);
      DateTime toDate = DateFormat('yyyy-MM-dd').parse(to.text);
      Duration difference = toDate.difference(fromDate);
      dateDifference = ' ${difference.inDays} days.';
    } else {
      dateDifference = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'image/add/Date.png',
                  width: 220,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    'Enter From To Date',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    readOnly: true,
                    controller: from,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: from.text.isNotEmpty
                            ? DateFormat('yyyy-MM-dd').parse(from.text)
                            : DateTime.now(),
                        firstDate: from.text.isNotEmpty
                            ? DateFormat('yyyy-MM-dd').parse(from.text)
                            : DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          from.text = formattedDate;
                          updateDateDifference();
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month_sharp),
                      filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      label:
                          Text('From', style: TextStyle(color: Colors.black38)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: TextField(
                    readOnly: true,
                    controller: to,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: from.text.isNotEmpty
                            ? DateFormat('yyyy-MM-dd').parse(from.text)
                            : DateTime.now(),
                        firstDate: from.text.isNotEmpty
                            ? DateFormat('yyyy-MM-dd').parse(from.text)
                            : DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          to.text = formattedDate;
                          updateDateDifference();
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month_sharp),
                      filled: true,
                      fillColor: Color.fromARGB(255, 245, 245, 245),
                      label:
                          Text('To', style: TextStyle(color: Colors.black38)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  dateDifference,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 85,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  height: 65,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 227, 227, 227),
                      ),
                    ),
                    onPressed: () {
                      Get.off(SelectStockType());
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
