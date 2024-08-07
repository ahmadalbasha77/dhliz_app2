import 'package:dhliz_app/config/utils.dart';
import 'package:dhliz_app/controllers/home/enter_stock_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../models/home/stock_model.dart';

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
    _controller.date.text = "";
    _controller.stockId.text = widget.data.id.toString();
    super.initState();
  }

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
        title:
            Text(widget.data.name, style: const TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.04, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(widget.data.photo),
                          radius: screenWidth * 0.12),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.data.name,
                                style:
                                    TextStyle(fontSize: screenWidth * 0.047)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('${'Stock ID'.tr} : ${widget.data.id}',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: screenWidth * 0.026)),
                            SizedBox(
                              height: 7.h,
                            ),
                            Text('${'Barcode'.tr}: ${widget.data.code}',
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 12)),
                            SizedBox(
                              height: 7.h,
                            ),
                            Text('${"upc".tr}: ${widget.data.upc}',
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 12)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(widget.data.description,
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 13)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  '${'The space to be enter'.tr} :',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 38, 50, 56),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter space';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: _controller.space,
                    decoration: InputDecoration(
                        suffixText: 'M²'.tr,
                        suffixStyle: const TextStyle(
                            fontSize: 16, color: Colors.black54),
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter date'.tr,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 38, 50, 56),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
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
                        // output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        // formatted date => 2021-03-16

                        setState(() {
                          _controller.date.text =
                              formattedDate; // set output date to TextField value.
                        });
                      } else {}
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
                SizedBox(
                  height: 40.h,
                ),
                GetBuilder<EnterStockController>(
                  builder: (controller) => Row(
                    children: [
                      Expanded(
                        child: Text("ID of the inventory deliverer".tr,
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                      ),
                      _controller.selectedImage == null
                          ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.white),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              onPressed: () {
                                _controller.showImageOptions(context);
                              },
                              child: Text(
                                'Upload image'.tr,
                                style: const TextStyle(color: Colors.black),
                              ))
                          : const Text('تم التحميل')
                    ],
                  ),
                ),

                const SizedBox(
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
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 70.w, vertical: 15.h)),
                          backgroundColor: const MaterialStatePropertyAll(
                              Color.fromRGBO(80, 46, 144, 1.0)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          if (_controller.selectedImage == null) {
                            Utils.showSnackBar(
                                'warning'.tr, 'please upload image');
                          } else {
                            _controller.enterStock(context, actionType: '1');
                          }
                        }

                        // postData();
                      },
                      child: Text('Enter Now'.tr)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
