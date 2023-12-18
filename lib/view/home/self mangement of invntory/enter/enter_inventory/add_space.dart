import 'package:dhliz_app/view/home/self%20mangement%20of%20invntory/enter/enter_inventory/pay_screen.dart';
import 'package:flutter/material.dart';

import 'select_date.dart';

class AddSpace extends StatefulWidget {

  const AddSpace({super.key});

  @override
  State<AddSpace> createState() => _AddSpaceState();
}

class _AddSpaceState extends State<AddSpace> {
  @override
  Widget build(BuildContext context) {
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
                  'image/add/Space.png',
                  width: 220,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Enter the Space',
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
                  width: 180,
                  child: Text(
                    'Enter the Space of the item that you went to save ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                      decoration: InputDecoration(
                          suffixText: 'M²',
                          suffixStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                          filled: true,
                          fillColor: Color.fromARGB(255, 245, 245, 245),
                          label: Text('space',
                              style: TextStyle(color: Colors.black38)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none))),
                ),
                SizedBox(
                  height: 90,
                ),
                Text('10 M² = 10 Woorden Pallets',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 100,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    height: 65,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 227, 227, 227),
                            )),
                        onPressed: () {

                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
