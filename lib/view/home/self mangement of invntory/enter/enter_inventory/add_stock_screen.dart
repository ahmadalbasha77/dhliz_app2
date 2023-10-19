import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_capture_field/image_capture_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({Key? key}) : super(key: key);

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  String? x;
  var selected;
  bool isSelectRadio = false;
  final nameController = TextEditingController();
  final weightController = TextEditingController();
  final _controller = ImageCaptureController();

  Uint8List? _image;

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('no image selected');
    return null;
  }

  String result = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: screenSize.width * 0.07,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: screenSize.width * 0.08,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                              'image/home/inventory_2_black_24dp.png'),
                        ),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(Icons.add_a_photo_sharp),
                      iconSize: screenSize.width * 0.05,
                    ),
                    bottom: -screenSize.width * 0.03,
                    left: screenSize.width * 0.08,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.04,
                  vertical: screenSize.height * 0.015),
              child: TextField(
                controller: nameController,
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
                controller: weightController,
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
                controller: TextEditingController(text: result),
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
          ],
        ),
      ),
    );
  }
}
