import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../../config/app_color.dart';
import '../../../../config/constant.dart';
import '../../../../config/enum/action_enum.dart';
import '../../../../network/api_url.dart';
import '../../../main/home_screen.dart';
import '../warehouse management/my_warehouse_screen.dart';

class AddStockScreen extends StatefulWidget {
  int id;

  AddStockScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  void postData() async {
    final String apiUrl =
        '${ApiUrl.API_BASE_URL}/Stock/Create';

    Map<String, dynamic> requestBody = {
      "name": controllerName.text,
      "code": controllerCode.text,
      "brand": controllerBrand.text,
      "upc": controllerUpc.text,
      "photo": _image!.path.toString(),
      "description": controllerDescription.text,
      "capacity": controllerCapacity.text,
      "subscriptionId": widget.id,
      "temperature": {
        "high": true,
        "warm": true,
        "roomTemperature": true,
        "cold": true,
        "freezing": true,
        "createdDate": null,
        "updateDate": null,
        "createdBy": null,
        "updateBy": null
      },
      "materialType": {
        "name": "string",
        "createdDate": null,
        "updateDate": null,
        "createdBy": null,
        "updateBy": null
      },
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("POST request successful!");
      print("Response: ${response.body}");

      // Parse the JSON response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyWareHouseScreen()),
      );
      // Now you can use the postId variable as needed.
    } else {
      print("Failed to make POST request. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  }

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCapacity = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerBrand = TextEditingController();
  TextEditingController controllerUpc = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  File? _image;

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image!.path);
        print('=====================');
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

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
              _getImageFromGallery();
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

    print(widget.id);
    super.initState();
  }

  String result = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          postData();
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
          "Add Stock".tr,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 10.h),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(100.r)),
                  onTap: () async {
                    showOptions();
                  },
                  child: _image != null
                      ? Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: FileImage(_image!),
                                radius: 50,
                              )
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
                controller: controllerName,
                decoration: InputDecoration(
                  label: Text(
                    'Name stock'.tr,
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
                controller: controllerCapacity,
                decoration: InputDecoration(
                  suffixText: 'M²'.tr,
                  label: Text(
                    'space'.tr,
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
                controller: controllerCode,
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
                    'Barcode scanner (optional)'.tr,
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
                controller: controllerBrand,
                decoration: InputDecoration(
                  label: Text(
                    'Unit'.tr,
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
                controller: controllerUpc,
                decoration: InputDecoration(
                  label: Text(
                    'The number'.tr,
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
                controller: controllerDescription,
                decoration: InputDecoration(
                  label: Text(
                    'Stock description'.tr,
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
    );
  }
}
