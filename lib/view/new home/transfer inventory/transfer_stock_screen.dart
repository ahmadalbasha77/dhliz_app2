import 'package:dhliz_app/config/app_color.dart';
import 'package:dhliz_app/controllers/home/all_stock_controller.dart';
import 'package:dhliz_app/controllers/home/transfer_stock_controller.dart';
import 'package:dhliz_app/models/home/stock_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransferStockScreen extends StatefulWidget {
  final StockDataModel data;

  const TransferStockScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<TransferStockScreen> createState() => _TransferStockScreenState();
}

class _TransferStockScreenState extends State<TransferStockScreen> {
  final _controller = TransferStockController.to;
  final _stockController = AllStockController.to;

  @override
  void initState() {
    _controller.fromStockId.text = widget.data.id.toString();
    print(_controller.fromStockId.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.data.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AllStockController>(
          builder: (controller) => _stockController.dataAllStock.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenWidth * 0.03,
                          horizontal: screenWidth * 0.05),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
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
                                        NetworkImage(widget.data.photo),
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
                                child: Text(widget.data.name,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.05)),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.008),
                                child: Text(widget.data.id.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: screenWidth * 0.026)),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenWidth * 0.02,
                                    left: screenWidth * 0.008,
                                    bottom: screenWidth * 0.015),
                                child: Text('Description'.tr),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenWidth * 0.002,
                                    left: screenWidth * 0.008,
                                    bottom: screenWidth * 0.015),
                                child: Text(widget.data.description,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.025,
                                        color: Colors.black54)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   margin: EdgeInsets.symmetric(
                    //       vertical: screenWidth * 0.01, horizontal: screenWidth * 0.05),
                    //   padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
                    //   decoration: BoxDecoration(
                    //       color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.symmetric(
                    //             horizontal: screenWidth * 0.05,
                    //             vertical: screenWidth * 0.04),
                    //         child: Text('Warehouse name',
                    //             style: TextStyle(fontSize: screenWidth * 0.045)),
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.symmetric(
                    //             horizontal: screenWidth * 0.07,
                    //             vertical: screenWidth * 0.015),
                    //         child: Text('${'Address WH'.tr} : amman',
                    //             style: TextStyle(color: Colors.black54)),
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.only(
                    //             bottom: screenWidth * 0.02,
                    //             left: screenWidth * 0.07,
                    //             right: screenWidth * 0.07,
                    //             top: screenWidth * 0.015),
                    //         child: Text('${'Warehouse name'.tr} : wh1',
                    //             style: TextStyle(color: Colors.black54)),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.02,
                            horizontal: screenWidth * 0.05),
                        child: Text(
                          '${'The space to be transfer'.tr} : ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 38, 50, 56),
                              fontWeight: FontWeight.w500),
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _controller.space,
                          decoration: InputDecoration(
                              suffixText: 'M²',
                              suffixStyle: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                              filled: true,
                              fillColor: Colors.white,
                              label: Text('space'.tr,
                                  style: TextStyle(color: Colors.black54)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none))),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: screenWidth * 0.04,
                          left: screenWidth * 0.05,
                          right: screenWidth * 0.05,
                          bottom: screenWidth * 0.02),
                      child: Text('Transfer to'.tr,
                          style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.05,
                            horizontal: screenWidth * 0.025,
                          ),
                          label: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025,
                            ),
                            child: Text(
                              'Stock Name'.tr,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ),
                        value: _controller.selected,
                        onChanged: (val) {
                          setState(() {
                            _controller.selected = val;
                            print(_controller.selected);
                          });
                        },
                        items: _stockController.dataAllStock.map((item) {
                          return DropdownMenuItem(
                            value: item['id'],
                            // Adjust this based on your data structure
                            child: Text(
                              item['name'].toString(),
                              // Adjust this based on your data structure
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.02,
                            horizontal: screenWidth * 0.05),
                        child: Text(
                          'Transfer date'.tr,
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
                          controller: _controller.date,
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
                                _controller.date.text =
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
                            label: Text('date'.tr,
                                style: TextStyle(color: Colors.black54)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                          )),
                    ),
                    SizedBox(
                      height: screenWidth * 0.4,
                    ),
                    Center(
                      child: SizedBox(
                        width: screenWidth * 0.7,
                        height: screenWidth * 0.14,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColor.buttonColor),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.03)))),
                            onPressed: () {
                              _controller.transferStock(context);
                            },
                            child: Text("Transfer now".tr)),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
