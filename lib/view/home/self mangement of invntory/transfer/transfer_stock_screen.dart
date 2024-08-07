import 'package:dhliz_app/config/app_color.dart';
import 'package:dhliz_app/config/utils.dart';
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

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    _controller.stockId = widget.data.id.toString();
    _controller.getAllStockByCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.data.name,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<TransferStockController>(
          builder: (controller) => Form(
            key: _key,
            child: Column(
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
                                style: TextStyle(fontSize: screenWidth * 0.05)),
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
                const SizedBox(
                  height: 25,
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.02,
                        horizontal: screenWidth * 0.05),
                    child: Text(
                      '${'The space to be transfer'.tr} : ',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 38, 50, 56),
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                      validator: (value) {
                        // Check if the value is null or empty
                        if (value == null || value.isEmpty) {
                          return 'Please enter space'
                              .tr; // Custom error message
                        }
                        // Parse the value to an integer safely
                        final valueAsInt = int.tryParse(value);
                        if (valueAsInt == null) {
                          return 'Please enter a valid number'
                              .tr; // Custom error message for non-numeric input
                        }
                        if (widget.data.capacity == 0) {
                          return 'no stock to transfer'.tr;
                        }
                        // Perform the comparison
                        if (valueAsInt > widget.data.capacity) {
                          return 'The entered space must be less than ${widget.data.capacity} M²'
                              .tr;
                        }
                        // Return null if there are no errors
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: _controller.space,
                      decoration: InputDecoration(
                          suffixText: 'M²',
                          suffixStyle:
                              const TextStyle(fontSize: 16, color: Colors.black54),
                          filled: true,
                          fillColor: Colors.white,
                          label: Text('space'.tr,
                              style: const TextStyle(color: Colors.black54)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none))),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.02,
                      horizontal: screenWidth * 0.05),
                  child: Text('Transfer to'.tr,
                      style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  height: 5,
                ),
                GetBuilder<TransferStockController>(
                  builder: (stockController) {
                    // Filter out the current stock using its ID.
                    var filteredStocks = stockController.allStocks
                        .where((stock) =>
                            stock.id.toString() != _controller.stockId)
                        .toList();

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              _controller.selectedStockId!.isEmpty) {
                            return 'enter stock name '.tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.03,
                            horizontal: screenWidth * 0.025,
                          ),
                          label: Text('Stock Name'.tr,
                              style: const TextStyle(color: Colors.black54)),
                        ),
                        value: _controller.selectedStockId,
                        onChanged: (String? newValue) {
                          _controller.setSelectedStockId(newValue);
                        },
                        items: filteredStocks.map<DropdownMenuItem<String>>(
                            (StockDataModel stock) {
                          return DropdownMenuItem<String>(
                            value: stock.id.toString(),
                            child: Text(stock.name,
                                style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.02,
                        horizontal: screenWidth * 0.05),
                    child: Text(
                      'Transfer date'.tr,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 38, 50, 56),
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter transfer date'.tr;
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
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          setState(() {
                            _controller.date.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month_sharp),
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('date'.tr,
                            style: const TextStyle(color: Colors.black54)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                      )),
                ),
                SizedBox(
                  height: screenWidth * 0.1,
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text("Inventory recipient ID".tr,
                            style: const TextStyle(
                              fontSize: 16,
                            ))),
                    _controller.selectedImage == null
                        ? ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    const MaterialStatePropertyAll(Colors.white),
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
                              style: const TextStyle(color: Colors.black),
                            ))
                        : Text('Uploaded'.tr)
                  ],
                ),
                SizedBox(
                  height: screenWidth * 0.14,
                ),
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.7,
                    height: screenWidth * 0.14,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColor.buttonColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.03)))),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            if (_controller.selectedImage != null) {
                              _controller.transferStock(context, actionType: '2');
                            } else {
                              Utils.showSnackBar(
                                  'warning', 'please upload image'.tr);
                            }
                          } else {
                            if (_controller.selectedImage == null) {
                              Utils.showSnackBar(
                                  'warning', 'please upload image'.tr);
                            }
                          }
                        },
                        child: Text("Transfer now".tr)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
