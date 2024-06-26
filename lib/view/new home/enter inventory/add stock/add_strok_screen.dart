import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../../../config/app_color.dart';

import '../../../../controllers/home/add_stock_controller.dart';

class AddStockNewScreen extends StatefulWidget {
  String id;

  AddStockNewScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<AddStockNewScreen> createState() => _AddStockNewScreenState();
}

class _AddStockNewScreenState extends State<AddStockNewScreen> {
  final _controller = AddStockController.to;
  bool isLoading = false;

  final keyForm = GlobalKey<FormState>();

  // File? _image;

  // File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this._controller.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _controller.image = File(pickedFile.path);
        print(_controller.image!.path);
        print('=====================');
      } else {
        print('No image selected.');
      }
    });
  }

  // Future<void> _getImageFromGallery() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //       print(_image);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'.tr),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              pickImage();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'.tr),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              _getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _controller.subscriptionId = widget.id;
    super.initState();
  }

  String result = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.buttonColor,
        onPressed: () {
          if (keyForm.currentState!.validate()) {
            if (_controller.image == null) {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'Please enter image stock',
                  duration: const Duration(seconds: 3),
                ),
              );
            } else {
              _controller.addStock();
              // createStockWithFile();
              // postData();
            }
          }
        },
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Add Stock".tr,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(height: 10.h),
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(100.r)),
                    onTap: () async {
                      showOptions();
                    },
                    child: _controller.image != null
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: FileImage(_controller.image!),
                                    radius: 50,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Container(
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
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                    vertical: screenSize.height * 0.015),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name stock';
                    }
                    return null;
                  },
                  controller: _controller.controllerName,
                  decoration: InputDecoration(
                    label: Text(
                      'Name stock'.tr,
                      style: TextStyle(color: Colors.black54),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(screenSize.width * 0.04),
                    ),
                  ),
                ),
              ),

              // Container(
              //   margin: EdgeInsets.symmetric(
              //       horizontal: screenSize.width * 0.04,
              //       vertical: screenSize.height * 0.015),
              //   child: TextFormField(
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter space';
              //       }
              //       return null;
              //     },
              //     keyboardType: TextInputType.number,
              //     controller: controllerCapacity,
              //     decoration: InputDecoration(
              //       suffixText: 'M²'.tr,
              //       label: Text(
              //         'space'.tr,
              //         style: TextStyle(color: Colors.black54),
              //       ),
              //       filled: true,
              //       fillColor: Colors.white,
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.white),
              //         borderRadius:
              //             BorderRadius.circular(screenSize.width * 0.04),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.white),
              //         borderRadius:
              //             BorderRadius.circular(screenSize.width * 0.04),
              //       ),
              //     ),
              //   ),
              // ),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                    vertical: screenSize.height * 0.015),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Brand stock';
                    }
                    return null;
                  },
                  controller: _controller.controllerBrand,
                  decoration: InputDecoration(
                    label: Text(
                      'Brand stock'.tr,
                      style: TextStyle(color: Colors.black54),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Upc stock';
                    }
                    return null;
                  },
                  // keyboardType: TextInputType.number,
                  controller: _controller.controllerUpc,
                  decoration: InputDecoration(
                    label: Text(
                      'Upc stock'.tr,
                      style: TextStyle(color: Colors.black54),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
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
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _controller.controllerCode,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {
                          var res =
                              await Get.to(() => SimpleBarcodeScannerPage());
                          setState(() {
                            if (res is String) {
                              _controller.controllerCode.text = res;
                            }
                          });
                        },
                        icon: Icon(Icons.qr_code_scanner_sharp,
                            color: Colors.black)),
                    label: Text(
                      'Barcode scanner (optional)'.tr,
                      style: TextStyle(color: Colors.black54),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Stock description';
                    }
                    return null;
                  },
                  controller: _controller.controllerDescription,
                  decoration: InputDecoration(
                    label: Text(
                      'Stock description'.tr,
                      style: TextStyle(color: Colors.black54),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(screenSize.width * 0.04),
                    ),
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.white),
                    //   borderRadius:
                    //       BorderRadius.circular(screenSize.width * 0.04),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.white),
                    //   borderRadius:
                    //       BorderRadius.circular(screenSize.width * 0.04),
                    // ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              // Container(
              //   // alignment: Alignment.centerRight,
              //   margin:
              //       EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
              //   child: Text('Stock Temperature'.tr,
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //       )),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(
              //       horizontal: screenSize.width * 0.04, vertical: 10.h),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius:
              //           BorderRadius.circular(screenSize.width * 0.04)),
              //   height: 40.h,
              //   child: ListView.builder(
              //     physics: ScrollPhysics(parent: ScrollPhysics()),
              //     scrollDirection: Axis.horizontal,
              //     itemCount: _controller.checkListItems.length,
              //     itemBuilder: (context, index) => Container(
              //         margin: EdgeInsets.symmetric(
              //             horizontal: screenSize.width * 0.04),
              //         child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Checkbox(
              //                 value: _controller.checkListItems[index]['value'],
              //                 onChanged: (value) {
              //                   setState(() {
              //                     _controller.checkListItems[index]['value'] =
              //                         value!;
              //                   });
              //                 },
              //               ),
              //               Text(
              //                 _controller.checkListItems[index]['title'],
              //                 style: TextStyle(
              //                     fontSize: 14, fontWeight: FontWeight.w500),
              //               ),
              //             ])),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
