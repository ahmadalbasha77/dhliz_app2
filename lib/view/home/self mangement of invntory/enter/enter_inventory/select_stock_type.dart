import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'map_screen.dart';

class SelectStockType extends StatefulWidget {
  const SelectStockType({super.key});

  @override
  State<SelectStockType> createState() => _SelectStockTypeState();
}

class _SelectStockTypeState extends State<SelectStockType> {
  final TextEditingController otherStockTypeController =
      TextEditingController();
  String selected = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'image/add/Stock Type.png',
                  width: 220,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Select Stock Type',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    'Choose the type of inventory you want to store',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                    vertical: screenSize.height * 0.015,
                  ),
                  child: Column(
                    children: [
                      DropdownSearch<String>(
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
                            fillColor: Color.fromARGB(255, 245, 245, 245),
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
                                'Stock Type',
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
                      if (selected == 'other')
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 245, 245, 245),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: screenSize.height * 0.028,
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
                        )
                    ],
                  ),
                ),
                SizedBox(
                  height: selected == 'other' ? 87 : 195,
                ),
                Container(
                  width: 240,
                  child: Text(
                    'Choosing the right type of material will help in choosing the right store',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  height: 65,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 227, 227, 227),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MapScreen(),
                      ));
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
