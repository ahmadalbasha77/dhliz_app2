import 'package:dhliz_app/controllers/home/enter_stock_controller.dart';
import 'package:dhliz_app/models/home/add_stock_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../models/home/stock_model.dart';

class AddEnterInventoryScreen extends StatefulWidget {
  final AddStockDataModel data;

  const AddEnterInventoryScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<AddEnterInventoryScreen> createState() => _AddEnterInventoryScreenState();
}

class _AddEnterInventoryScreenState extends State<AddEnterInventoryScreen> {
  final _controller = EnterStockController.to;

  String? x;
  var selected;
  TextEditingController date = TextEditingController();

  void initState() {
    print(widget.data.id);
    print(widget.data.name);
    date.text = "";
    _controller.stockId.text = widget.data.id.toString();
    print(widget.data);
    super.initState();
  }

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage; // Use late for late initialization
  XFile? proofImage; // Use late for late initialization
  bool isSelectedOne = false;
  bool isSelectedOTwo = false;

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  Future<void> _takePicture() async {
    final XFile? takenImage =
    await _imagePicker.pickImage(source: ImageSource.camera);
    if (takenImage != null) {
      setState(() {
        _selectedImage = takenImage;
      });
    }
  }

  void _showImageOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose an image".tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                trailing: Icon(Icons.photo),
                title: Text("From the gallery".tr),
                onTap: () {
                  _pickImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: Icon(Icons.camera),
                title: Text("Take photo".tr),
                onTap: () {
                  _takePicture();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.04, horizontal: screenWidth * 0.05),
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                            style:
                            TextStyle(color: Colors.black54, fontSize: 12)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        child: Text('${"upc".tr}: ${widget.data.upc}',
                            style:
                            TextStyle(color: Colors.black54, fontSize: 12)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 230,
                        margin: EdgeInsets.only(bottom: screenWidth * 0.015),
                        child: Text(widget.data.description,
                            style:
                            TextStyle(color: Colors.black87, fontSize: 13)),
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
              child: TextField(
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
              child: TextField(
                  readOnly: true,
                  controller: date,
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
                        date.text =
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
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      _showImageOptions();
                    },
                    child: Text(
                      'Upload image'.tr,
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Text("Attach the vehicle license".tr,
                        style: TextStyle(
                          fontSize: 16,
                        ))),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      _showImageOptions();
                    },
                    child: Text(
                      'Upload image'.tr,
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            SizedBox(
              height: 30,
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
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      _controller.enterStock(context);
                      // postData();
                    },
                    child: Text('Enter Now'.tr)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
