import 'package:flutter/material.dart';

import 'enter_inventory/add_stock_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 225, 225, 225),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Enter inventory",
              style: TextStyle(
                color: Colors.black,
              )),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(25),
                  child: Icon(Icons.filter_list, size: 30),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  height: 60,
                  width: 160,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black54)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddStockScreen(),
                        ));
                      },
                      child: Text("Add Stock")),
                )
              ],
            ),
            Container(
              height: 582,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text('wh',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Text(
                                      'weight :20 ',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                    )),
                                Container(
                                    child: Text(
                                  'stock Id :1002',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 13),
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => InventoryScreen(),
                                      ));
                                    },
                                    child: Text('View Details',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('image/dehliz/1633444786084.jpeg'),
                          ),
                          width: 110,
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
