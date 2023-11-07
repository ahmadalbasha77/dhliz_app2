import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhliz_app/controllers/home/add_edit_inventory_controller.dart';
import 'package:dhliz_app/models/home/inventory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';


import '../../../../../config/app_color.dart';
import '../../../../../config/constant.dart';
import '../../../../../config/enum/action_enum.dart';


class AddStockScreen extends StatefulWidget {
  final ActionEnum action;
  final InventoryDataModel data;

  const AddStockScreen({Key? key, required this.action, required this.data})
      : super(key: key);

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  final _controller = AddEditInventoryController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.action == ActionEnum.edit) {
      _controller.id.value = widget.data.id;
    }
    _controller.controllerTitle.text = widget.data.title;
    _controller.controllerDescription.text = widget.data.description;
    _controller.controllerUrl.text = widget.data.url;
  }

  String result = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          _controller.addEditInventory2();
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Add Stock",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AddEditInventoryController>(
          builder: (controller) => Form(
            key: _controller.keyForm,
            child: Column(
              children: [
                if (widget.action == ActionEnum.info ||
                    widget.action == ActionEnum.edit)
                  widget.data.image.isEmpty || _controller.image.value != null
                      ? Container()
                      : CachedNetworkImage(
                          imageUrl: widget.data.image,
                          width: 150.w,
                          fit: BoxFit.fitWidth,
                        ),
                if (widget.action == ActionEnum.add ||
                    widget.action == ActionEnum.edit)
                  Column(
                    children: [
                      Text(
                        'Add Image'.tr,
                        style: kStyleTextTitle,
                      ),
                      SizedBox(height: 10.h),
                      InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(100.r)),
                        onTap: () async {
                          _controller.selectImage();
                        },
                        child: _controller.image.value != null
                            ? Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(FontAwesomeIcons.image),
                                    SizedBox(width: 8.w),
                                    Flexible(
                                      child:
                                          Text(_controller.image.value!.name),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(16.sp),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.r)),
                                  color: AppColor.darkGray,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.plus,
                                  size: 60.sp,
                                ),
                              ),
                      ),
                    ],
                  ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.04,
                      vertical: screenSize.height * 0.015),
                  child: TextField(
                    controller: _controller.controllerTitle,
                    decoration: InputDecoration(
                      label: Text(
                        'Name',
                        style: TextStyle(color: Colors.black54),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                            BorderRadius.circular(screenSize.width * 0.04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                            BorderRadius.circular(screenSize.width * 0.04),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.04,
                      vertical: screenSize.height * 0.015),
                  child: TextField(
                    controller: _controller.controllerDescription,
                    decoration: InputDecoration(
                      suffixText: 'M²',
                      label: Text(
                        'Space',
                        style: TextStyle(color: Colors.black54),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                            BorderRadius.circular(screenSize.width * 0.04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                            BorderRadius.circular(screenSize.width * 0.04),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.04,
                      vertical: screenSize.height * 0.015),
                  child: TextField(
                    controller: _controller.controllerUrl,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () async {
                            var res = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SimpleBarcodeScannerPage(),
                                ));
                            setState(() {
                              if (res is String) {
                                result = res;
                              }
                            });
                          },
                          icon: Icon(Icons.qr_code_scanner_sharp,
                              color: Colors.black)),
                      label: Text(
                        'Barcode scanner (optional)',
                        style: TextStyle(color: Colors.black54),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                            BorderRadius.circular(screenSize.width * 0.04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                            BorderRadius.circular(screenSize.width * 0.04),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.04,
                      vertical: screenSize.height * 0.015),
                  child: TextField(
                    controller: _controller.controllerTitle,
                    decoration: InputDecoration(
                      label: Text(
                        'Unit',
                        style: TextStyle(color: Colors.black54),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.04,
                      vertical: screenSize.height * 0.015),
                  child: TextField(
                    controller: _controller.controllerTitle,
                    decoration: InputDecoration(
                      label: Text(
                        'The number',
                        style: TextStyle(color: Colors.black54),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.04,
                      vertical: screenSize.height * 0.015),
                  child: TextField(
                    controller: _controller.controllerTitle,
                    decoration: InputDecoration(
                      label: Text(
                        'The number',
                        style: TextStyle(color: Colors.black54),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.04,
                      vertical: screenSize.height * 0.015),
                  child: TextField(
                    controller: _controller.controllerTitle,
                    decoration: InputDecoration(
                      label: Text(
                        'The details',
                        style: TextStyle(color: Colors.black54),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04),
                      ),
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
