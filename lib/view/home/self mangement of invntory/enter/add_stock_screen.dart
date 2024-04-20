import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../../config/app_color.dart';
import '../../../../config/shared_prefs_client.dart';
import '../../../../config/utils.dart';
import '../../../../network/api_url.dart';
import 'Inventory_details.dart';

class AddStockScreen extends StatefulWidget {
  int id;

  AddStockScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  List checkListItems = [
    {
      "id": 1,
      "value": false,
      "title": "Dry".tr,
    },
    {
      "id": 2,
      "value": false,
      "title": "Cold".tr,
    },
    {
      "id": 3,
      "value": false,
      "title": "Freezing".tr,
    }
  ];
  bool isLoading = false;

  final keyForm = GlobalKey<FormState>();

  void postData() async {
    setState(() {
      isLoading = true;
    });
    final String apiUrl = '${ApiUrl.API_BASE_URL}/Stock/Create';

    Map<String, dynamic> requestBody = {
      "name": controllerName.text,
      "code": controllerCode.text,
      "brand": controllerBrand.text,
      "upc": controllerUpc.text,
      "photo": _image!.path.toString(),
      "description": controllerDescription.text,
      "capacity": 0,
      "temperature": {
        "high": checkListItems[0]['value'],
        "cold": checkListItems[1]['value'],
        "freezing": checkListItems[2]['value']
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

  Future<void> createStockWithFile() async {
    var url = Uri.parse('${ApiUrl.API_BASE_URL}/Stock/CreateWithFile');
    Utils.showLoadingDialog();
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      HttpHeaders.authorizationHeader:
          'Bearer ${sharedPrefsClient.accessToken}',
      // Replace with your access token
      HttpHeaders.contentTypeHeader: 'multipart/form-data',
    });

    request.fields['Stock.Name'] = controllerName.text;
    request.fields['Stock.Code'] = controllerCode.text;
    request.fields['Stock.Brand'] = controllerBrand.text;
    request.fields['Stock.UPC'] = controllerUpc.text;
    request.fields['Stock.Photo'] = '';
    request.fields['Stock.Description'] = controllerDescription.text;
    request.fields['Stock.Capacity'] = '0';
    request.fields['Stock.Temperature.High'] =
        checkListItems[0]['value'].toString();
    request.fields['Stock.Temperature.Cold'] =
        checkListItems[1]['value'].toString();
    request.fields['Stock.Temperature.Freezing'] =
        checkListItems[2]['value'].toString();
    request.fields['Stock.Temperature.Dry'] = 'false';
    request.fields['Stock.Temperature.Id'] = '1';
    // request.fields['Stock.Temperature.CreatedDate'] = controllerUpc.text;
    request.fields['Stock.MaterialType.Id'] = '1';
    // request.fields['Stock.MaterialType.CreatedDate'] = controllerUpc.text;
    request.fields['Stock.SubscriptionId'] = widget.id.toString();
    // request.fields['Stock.CreatedDate'] = controllerUpc.text;

    // Replace '/path/to/your/file' with the actual path of the file
    request.files.add(await http.MultipartFile.fromPath(
      'File',
      _image!.path,
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = utf8.decode(responseData);
      Map<String, dynamic> jsonResponse = json.decode(responseString);
      print(jsonResponse['response'][0]);
      print('***********************************');

      Get.off(() => InventoryDetailsScreen(
            data: jsonResponse['response'][0],
          ));
      print('Stock created successfully');
    } else {
      // Handle error response
      print('Failed to create stock. Status code: ${response.statusCode}');
    }
  }

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCapacity = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerBrand = TextEditingController();
  TextEditingController controllerUpc = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  File? _image;

  // File? image;

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
              createStockWithFile();
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
                    child: _image != null
                        ? Center(
                            child: Padding(
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
                  controller: controllerName,
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
                  controller: controllerBrand,
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
                  controller: controllerUpc,
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
                  controller: controllerCode,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {
                          var res =
                              await Get.to(() => SimpleBarcodeScannerPage());
                          setState(() {
                            if (res is String) {
                              controllerCode.text = res;
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
                  controller: controllerDescription,
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
              Container(
                // alignment: Alignment.centerRight,
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
                child: Text('Stock Temperature'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04, vertical: 10.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.04)),
                height: 40.h,
                child: ListView.builder(
                  physics: ScrollPhysics(parent: ScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: checkListItems.length,
                  itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.04),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: checkListItems[index]['value'],
                              onChanged: (value) {
                                setState(() {
                                  checkListItems[index]['value'] = value!;
                                });
                              },
                            ),
                            Text(
                              checkListItems[index]['title'],
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
