import 'package:dhliz_app/controllers/home/inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../models/home/inventory_model.dart';
import 'enter_inventory/add_stock_screen.dart';
import 'package:dhliz_app/config/enum/action_enum.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _controller = InventoryController.to;

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
                        Get.off(() =>
                            AddStockScreen(
                                data: InventoryDataModel.fromJson({}),
                                action: ActionEnum.add))?.then(
                            (value) => _controller.refreshPagingController());
                      },
                      child: Text("Add Stock")),
                )
              ],
            ),
            Expanded(
                child: PagedListView(
              pagingController: _controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<InventoryDataModel>(
                itemBuilder: (context, item, index) => InventoryItem(
                  title: item.title.toString(),
                  description: item.description.toString(),
                  imageUrl: item.image.toString(),
                  id: item.id.toString(),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class InventoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  const InventoryItem({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                Row(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          'weight :20 ',
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        )),
                    Container(
                        child: Text(
                      'stock Id :10002',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: TextButton(
                        onPressed: () {},
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
                backgroundImage: NetworkImage(imageUrl),
              ),
              width: 110,
            )
          ],
        ));
  }
}
