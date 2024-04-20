import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'map_screen.dart';

class AddWarehouseScreen extends StatefulWidget {
  const AddWarehouseScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddWarehouseScreen> createState() => _AddWarehouseScreenState();
}

class _AddWarehouseScreenState extends State<AddWarehouseScreen> {
  // NEW CODE ==============================================================
  List<dynamic> data = [];
  List<String> coordinatesList = [];
  TextEditingController capacityController = TextEditingController();

  // END NEW CODE ==========================================================

  List multipleSelected = [];
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
  String selected = '';
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  String dateDifference = "0";

  final _formKey = GlobalKey<FormState>();

  void updateDateDifference() {
    if (from.text.isNotEmpty && to.text.isNotEmpty) {
      DateTime fromDate = DateFormat('yyyy-MM-dd').parse(from.text);
      DateTime toDate = DateFormat('yyyy-MM-dd').parse(to.text);
      Duration difference = toDate.difference(fromDate);
      dateDifference = '${difference.inDays + 1}';
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
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title:
            Text('Add New Warehouse'.tr, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 250,
                  child: Text(
                    'Properties of the warehouse to be added to the warehouse list'
                        .tr,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                // alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Temperature'.tr,
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
                // alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text('Space Needed'.tr,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Container(
                // height: 80,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the space you need'.tr;
                      } else {}
                    },
                    keyboardType: TextInputType.number,
                    controller: capacityController,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        suffixText: 'M²'.tr,
                        suffixStyle:
                            TextStyle(fontSize: 16, color: Colors.black54),
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('space'.tr,
                            style: TextStyle(color: Colors.black38)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none))),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              //   child: Text('10 M²  = 12 wooden pallets'.tr,
              //       style: TextStyle(color: Colors.black38)),
              // ),
              SizedBox(
                height: 35,
              ),
              Container(
                // alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text('Booking Date'.tr,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 165,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the date'.tr;
                        } else {}
                      },
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
                        label: Text('From'.tr,
                            style: TextStyle(color: Colors.black38)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
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
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the date'.tr;
                        } else {}
                      },
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
                        label: Text('To'.tr,
                            style: TextStyle(color: Colors.black38)),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
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
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text('$dateDifference days',
                      style: TextStyle(color: Colors.black38)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Container(
              //   alignment: Alignment.centerRight,
              //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              //   child: Text('Stock Type'.tr,
              //       style:
              //           TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   child: DropdownSearch<String>(
              //     popupProps: PopupProps.menu(
              //       showSearchBox: true,
              //       disabledItemFn: (String s) => s.startsWith('I'),
              //     ),
              //     items: [
              //       "Foodstuffs".tr,
              //       "Chemicals".tr,
              //       "Electrical materials".tr,
              //       'other'.tr
              //     ],
              //     dropdownDecoratorProps: DropDownDecoratorProps(
              //       dropdownSearchDecoration: InputDecoration(
              //         filled: true,
              //         fillColor: Colors.white,
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(15),
              //           borderSide: BorderSide.none,
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(15),
              //           borderSide: BorderSide.none,
              //         ),
              //         contentPadding: EdgeInsets.symmetric(
              //           vertical: screenSize.height * 0.022,
              //           horizontal: screenSize.height * 0.015,
              //         ),
              //         label: Container(
              //           margin: EdgeInsets.symmetric(
              //             horizontal: screenSize.width * 0.025,
              //           ),
              //           child: Text(
              //             'Type'.tr,
              //             style: TextStyle(color: Colors.black38),
              //           ),
              //         ),
              //       ),
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         selected = value!;
              //       });
              //     },
              //   ),
              // ),
              // if (selected == 'other')
              //   Container(
              //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              //     child: TextField(
              //       decoration: InputDecoration(
              //         filled: true,
              //         fillColor: Colors.white,
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(15),
              //           borderSide: BorderSide.none,
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(15),
              //           borderSide: BorderSide.none,
              //         ),
              //         contentPadding: EdgeInsets.symmetric(
              //           vertical: screenSize.height * 0.022,
              //         ),
              //         label: Container(
              //           margin: EdgeInsets.symmetric(
              //             horizontal: screenSize.width * 0.025,
              //           ),
              //           child: Text(
              //             'What type of material ?'.tr,
              //             style: TextStyle(color: Colors.black38),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // SizedBox(
              //   height: selected == 'other' ? 2 : 40,
              // ),

              SizedBox(
                height: 100,
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
                        Color.fromRGBO(80, 46, 144, 1.0),
                      ),
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        Get.off(MapScreen(
                          space: int.tryParse(capacityController.text) ?? 0,
                          dry: checkListItems[0]['value'],
                          cold: checkListItems[1]['value'],
                          freezing: checkListItems[2]['value'],
                          from: from.text,
                          to: to.text,
                          days: dateDifference,
                        ));
                        print(checkListItems[0]['value'].toString());
                        print(checkListItems[1]['value'].toString());
                        print(checkListItems[2]['value'].toString());
                        print('************************************');
                        print(from.text);
                        print(to.text);
                      }


                    },
                    child: Text(
                      'Continue'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
