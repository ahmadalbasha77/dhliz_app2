import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhliz_app/controllers/home/add_edit_warehouse_controller.dart';
import 'package:dhliz_app/models/home/my_warehouse_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import '../../../../config/constant.dart';
import '../../../../config/enum/action_enum.dart';


import '../enter/enter_inventory/map_screen.dart';

class AddWarehouseScreen extends StatefulWidget {
  final ActionEnum action;
  final MyWarehouseDataModel data;

  const AddWarehouseScreen({Key? key, required this.action, required this.data})
      : super(key: key);

  @override
  State<AddWarehouseScreen> createState() => _AddWarehouseScreenState();
}

class _AddWarehouseScreenState extends State<AddWarehouseScreen> {


  // NEW CODE ==============================================================
  List<dynamic> data = [];
  List<String> coordinatesList = [];
  TextEditingController capacityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
    from.text = "";
    to.text = "";
    dateDifference = "";
    super.initState();
    if (widget.action == ActionEnum.edit) {
      _controller.id.value = widget.data.id;
    }
    _controller.controllerTitle.text = widget.data.title;
  }

  Future<void> fetchData({int? capacity}) async {
    final Map<String, String> headers = {'ngrok-skip-browser-warning': 'latest'};
    final Uri uri = Uri.parse('https://10bf-81-253-114-36.ngrok-free.app/api/Warehouse/GetAllWarehouseLabelDto');

    final Map<String, dynamic> queryParameters = capacity != null ? {'Capacity': capacity.toString()} : {};
    final Uri filteredUri = uri.replace(queryParameters: queryParameters);

    final response = await http.get(filteredUri, headers: headers);

    if (response.statusCode == 200) {
      print('Request successful');
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        data = responseData['response'][0];

        // Clear the coordinates list before adding new coordinates
        coordinatesList.clear();

        // Extract and store coordinates
        for (final item in data) {
          String lat = item['lat'].toString();
          String lon = item['lot'].toString();
          String coordinates = '($lat, $lon)';
          coordinatesList.add(coordinates);
        }
      } else {
        print('API returned an error: ${responseData['error']}');
      }
    } else {
      print('Request failed');
      print('Failed to load data: ${response.statusCode}');
    }

    // Trigger a rebuild to display the data
    setState(() {});
  }

  // END NEW CODE ==========================================================

  final _controller = AddEditWarehouseController.to;

  List multipleSelected = [];
  List checkListItems = [
    {
      "id": 1,
      "value": false,
      "title": "Dry",
    },
    {
      "id": 2,
      "value": false,
      "title": "Cold",
    },
    {
      "id": 3,
      "value": false,
      "title": "Freezing",
    }
  ];
  String selected = '';
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  String dateDifference = "";



  void updateDateDifference() {
    if (from.text.isNotEmpty && to.text.isNotEmpty) {
      DateTime fromDate = DateFormat('yyyy-MM-dd').parse(from.text);
      DateTime toDate = DateFormat('yyyy-MM-dd').parse(to.text);
      Duration difference = toDate.difference(fromDate);
      dateDifference = ' ${difference.inDays} days.';
    } else {
      dateDifference = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        elevation: 0,
        title: Text('Add New Warehouse', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AddEditWarehouseController>(
          builder: (controller) => Form(
            key: _controller.keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Properties of the warehouse to \nbe added to the warehouse list',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Temperature',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 50,
                  child: ListView.builder(
                    physics: ScrollPhysics(parent: ScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    itemCount: checkListItems.length,
                    itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text('Space Needed',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                      controller: capacityController,
                      decoration: InputDecoration(
                          suffixText: 'M²',
                          suffixStyle:
                              TextStyle(fontSize: 16, color: Colors.black54),
                          filled: true,
                          fillColor: Colors.white,
                          label: Text('space',
                              style: TextStyle(color: Colors.black38)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none))),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text('10 M²  = 12 wooden pallets',
                      style: TextStyle(color: Colors.black38)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text('Booking Date',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 165,
                      child: TextField(
                        readOnly: true,
                        controller: from,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: from.text.isNotEmpty
                                ? DateFormat('yyyy-MM-dd').parse(from.text)
                                : DateTime.now(),
                            firstDate: from.text.isNotEmpty
                                ? DateFormat('yyyy-MM-dd').parse(from.text)
                                : DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              from.text = formattedDate;
                              updateDateDifference();
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month_sharp),
                          filled: true,
                          fillColor: Colors.white,
                          label: Text('From',
                              style: TextStyle(color: Colors.black38)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 165,
                      child: TextField(
                        readOnly: true,
                        controller: to,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: from.text.isNotEmpty
                                ? DateFormat('yyyy-MM-dd').parse(from.text)
                                : DateTime.now(),
                            firstDate: from.text.isNotEmpty
                                ? DateFormat('yyyy-MM-dd').parse(from.text)
                                : DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              to.text = formattedDate;
                              updateDateDifference();
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month_sharp),
                          filled: true,
                          fillColor: Colors.white,
                          label: Text('To',
                              style: TextStyle(color: Colors.black38)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text(dateDifference,
                      style: TextStyle(color: Colors.black38)),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text('Stock Type',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                    items: [
                      "Foodstuffs",
                      "Chemicals",
                      "Electrical materials",
                      'other'
                    ],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.022,
                          horizontal: screenSize.height * 0.015,
                        ),
                        label: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.025,
                          ),
                          child: Text(
                            'Type',
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selected = value!;
                      });
                    },
                  ),
                ),
                if (selected == 'other')
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.022,
                        ),
                        label: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.025,
                          ),
                          child: Text(
                            'what type of material ?',
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                      ),
                    ),
                  ),

                SizedBox(
                  height: selected == 'other' ? 2 : 40,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    height: 65,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 227, 227, 227),
                        ),
                      ),
                      onPressed: () {

                        int? capacity = int.tryParse(capacityController.text);
                        if (capacity != null) {
                          fetchData(capacity: capacity);
                        } else {
                          print('Invalid capacity value');
                        }
                        Get.off( MapScreen(temp: 'temp', fromDate: 'fromDate', toDate: 'toDate', numberOfDays: 'numberOfDays', stockType: 'stockType' , coordinatesList: coordinatesList ,));
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.black54, fontSize: 20),
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
