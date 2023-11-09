import 'package:dhliz_app/models/home/my_warehouse_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../config/enum/action_enum.dart';
import '../../../../../controllers/home/my_warehouse_controllerl.dart';

import '../../../thank_you.dart';
import '../enter/inventory_screen.dart';
import 'add_warehouse_screen.dart';

bool value = false;
List multipleSelected = [];
List checkListItems = [
  {
    "id": 0,
    "value": false,
    "title": "Dry",
  },
  {
    "id": 1,
    "value": true,
    "title": "Cold ",
  },
  {
    "id": 2,
    "value": true,
    "title": "Freezing",
  },
];

class MyWareHouseScreen extends StatefulWidget {
  const MyWareHouseScreen({super.key});

  @override
  State<MyWareHouseScreen> createState() => _MyWareHouseScreenState();
}

class _MyWareHouseScreenState extends State<MyWareHouseScreen> {
  final _controller = MyWarehouseController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.refreshPagingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text('My Warehouse',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    width: 130,
                    height: 45,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 35, 37, 56),
                            )),
                        onPressed: () {
                          Get.off(() =>
                              AddWarehouseScreen(
                                  data: MyWarehouseDataModel.fromJson({}),
                                  action: ActionEnum.add))?.then(
                              (value) => _controller.refreshPagingController());
                        },
                        child: Text(
                          'Add Werehouse',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ))),
              ],
            ),
            Expanded(
              child: PagedListView(
                pagingController: _controller.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<MyWarehouseDataModel>(
                  itemBuilder: (context, item, index) => Padding(
                      padding: EdgeInsets.all(7),
                      child: MyWarehouseItem(
                          title: item.title.toString(),
                          description: item.description.toString(),
                          imageUrl: item.image.toString())),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyWarehouseItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const MyWarehouseItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InventoryScreen(),
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 35,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 35, 37, 56),
                          )),
                      onPressed: () {
                        Get.off(ThankYouScreen());
                      },
                      child: Text(
                        'View map',
                        style: TextStyle(fontSize: 12),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Address : Amman , jabal alhusan , Yafa 33  ',
                style: TextStyle(
                  fontSize: 11,
                )),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text('Price : 12 SAR / 1 M² per month',
                  style: TextStyle(
                    fontSize: 11,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text('Temperature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 45,
              child: GridView.builder(
                physics: ScrollPhysics(parent: ScrollPhysics()),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 4.5),
                itemCount: checkListItems.length,
                itemBuilder: (context, index) => Container(
                    child: Row(children: [
                  AbsorbPointer(
                    absorbing: true,
                    child: Checkbox(
                      fillColor: MaterialStatePropertyAll(Colors.black),
                      value: checkListItems[index]['value'],
                      onChanged: (bool? value) {},
                    ),
                  ),
                  Text(
                    checkListItems[index]['title'],
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ])),
              ),
            ),
            Row(
              children: [
                Text('Used',
                    style: TextStyle(fontSize: 14, color: Colors.black54)),
                LinearPercentIndicator(
                  barRadius: Radius.circular(15),
                  width: 250,
                  lineHeight: 14.0,
                  percent: .2,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.black54,
                ),
                Text(
                  '20%',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total : 133/month',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 35, 37, 56),
                      )),
                  Text(
                    'spece :12 M²',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 35, 37, 56),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expired WH : 12/10/2023    30 Days',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 253, 191, 8),
                          )),
                      onPressed: () {
                        Get.off(ThankYouScreen());
                      },
                      child: Text(
                        'Upgrade Space',
                        style: TextStyle(fontSize: 10),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
