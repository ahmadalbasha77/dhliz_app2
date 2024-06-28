import 'package:dhliz_app/config/utils.dart';
import 'package:dhliz_app/controllers/home/enter_stock_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/home/stock_model.dart';

class EnterInventoryScreen extends StatefulWidget {
  final StockDataModel data;

  const EnterInventoryScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<EnterInventoryScreen> createState() => _EnterInventoryScreenState();
}

class _EnterInventoryScreenState extends State<EnterInventoryScreen> {
  final _controller = EnterStockController.to;
  final GlobalKey<FormState> _key = GlobalKey();

  String? x;
  var selected;

  @override
  void initState() {
    print(widget.data.id);
    print(widget.data.name);
    _controller.date.text = "";
    _controller.stockId.text = widget.data.id.toString();
    print(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Enter Stock', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.04,
                    horizontal: screenWidth * 0.05),
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
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
                              backgroundImage: NetworkImage(widget.data.photo),
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
                              bottom: screenWidth * 0.01),
                          child: Text(widget.data.name,
                              style: TextStyle(fontSize: screenWidth * 0.047)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.008),
                          child: Text('${'Stock ID'.tr} : ${widget.data.id}',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: screenWidth * 0.026)),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          child: Text('${'Barcode'.tr}: ${widget.data.code}',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12)),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          child: Text('${"upc".tr}: ${widget.data.upc}',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 230,
                          margin: EdgeInsets.only(bottom: screenWidth * 0.015),
                          child: Text(widget.data.description,
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 13)),
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
                    '${'The space to be enter'.tr} :',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 38, 50, 56),
                        fontWeight: FontWeight.w500),
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter space';
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: _controller.space,
                    decoration: InputDecoration(
                        suffixText: 'M²'.tr,
                        suffixStyle:
                        TextStyle(fontSize: 16, color: Colors.black54),
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
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.02,
                      horizontal: screenWidth * 0.05),
                  child: Text(
                    'Enter date'.tr,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 38, 50, 56),
                        fontWeight: FontWeight.w500),
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter enter date';
                      }
                      return null;
                    },
                    readOnly: true,
                    controller: _controller.date,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); // output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate); // formatted date => 2021-03-16

                        setState(() {
                          _controller.date.text =
                              formattedDate; // set output date to TextField value.
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
                height: 30,
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(" ID of the inventory deliverer".tr,
                          style: TextStyle(
                            fontSize: 16,
                          ))),
                  _controller.selectedImage == null
                      ? ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)))),
                      onPressed: () {
                        _controller.showImageOptions(context);
                        setState(() {});
                      },
                      child: Text(
                        'Upload image'.tr,
                        style: TextStyle(color: Colors.black),
                      ))
                      : Text('تم التحميل')
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Center(
              //   child: Container(
              //     width: 350,
              //     margin: EdgeInsets.symmetric(horizontal: 20),
              //     child: Text(
              //         textAlign: TextAlign.center,
              //         'Note: The stock to be stored must be the same as the stored stock'
              //             .tr,
              //         style: TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black54)),
              //   ),
              // ),
              Center(
                child: Container(
                  width: 270,
                  height: 60,
                  margin: EdgeInsets.only(top: 25),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                              Color.fromRGBO(80, 46, 144, 1.0)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          if (_controller.selectedImage == null) {
                            Utils.showSnackbar('warning', 'please upload image');
                          } else {
                            _controller.enterStock(context, actionType: '1');
                          }
                        }

                        // postData();
                      },
                      child: Text('Enter Now'.tr)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
