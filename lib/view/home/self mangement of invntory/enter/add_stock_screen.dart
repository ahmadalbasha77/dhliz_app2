import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../../config/app_color.dart';
import '../../../../config/shared_prefs_client.dart';
import '../../../../network/api_url.dart';
import 'Inventory_details.dart';

class AddStockScreen extends StatefulWidget {
  int id;

  AddStockScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  bool isLoading = false;

  final keyForm = GlobalKey<FormState>();

  void postData() async {
    setState(() {
      isLoading = true;
    });
    final String apiUrl = '${ApiUrl.API_BASE_URL}/Stock/Create';

    Map<String, dynamic> requestBody = {
      "id": 0,
      "name": controllerName.text,
      "code": controllerCode.text,
      "brand": controllerBrand.text,
      "upc": controllerUpc.text,
      "photo": _image!.path.toString(),
      "description": controllerDescription.text,
      "capacity": int.parse(controllerCapacity.text),
      "temperature": {
        "id": 0,
        "createdDate": "2024-02-06T09:22:46.662Z",
        "high": true,
        "cold": true,
        "freezing": true
      },
      "materialType": {
        "id": 0,
        "createdDate": "2024-02-06T09:22:46.662Z",
        "name": "string"
      },
      "subscriptionId": widget.id
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${sharedPrefsClient.accessToken}',
        'Content-Type': 'application/json', // Ensure Content-Type is set
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("POST request successful!");
      print("Response: ${response.body}");

      // Parse the JSON response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse['response'][0]);
      print('***********************************');

      Get.off(() => InventoryDetailsScreen(
            data: jsonResponse['response'][0],
          ));
      setState(() {
        isLoading = false;
      });
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

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

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
    print(widget.id);
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
            if (_image == null) {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'Please enter image stock',
                  duration: const Duration(seconds: 3),
                ),
              );
            } else {
              postData();
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name stock';
                    }
                    return null;
                  },
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter space';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
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
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controllerCode,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {
                          var res =
                              await Get.to(() => SimpleBarcodeScannerPage());
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Unit';
                    }
                    return null;
                  },
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Unit';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Stock description';
                    }
                    return null;
                  },
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
      ),
    );
  }
}
