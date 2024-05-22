import 'package:dhliz_app/controllers/home/stock_controller.dart';
import 'package:dhliz_app/models/home/stock_model.dart';
import 'package:dhliz_app/view/new%20home/enter%20inventory/enter_inventory_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'add stock/add_strok_screen.dart';

class EnterInventoryNewScreen extends StatefulWidget {
  final String id;

  const EnterInventoryNewScreen({super.key, required this.id});

  @override
  State<EnterInventoryNewScreen> createState() => _EnterInventoryNewScreenState();
}

class _EnterInventoryNewScreenState extends State<EnterInventoryNewScreen> {
  final _controller = StockController.to;

  @override
  void initState() {

    print('EnterStockScreen initiated with ID: ${widget.id}');
    _controller.id = widget.id;
    super.initState();
    _controller.pagingController.addPageRequestListener((pageKey) {
      _controller.getStock(pageKey: pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Enter Stock'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
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
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(80, 46, 144, 1.0))),
                      onPressed: () {
                        Get.off(() => AddStockNewScreen(
                              id: _controller.id.toString(),
                            ));
                      },
                      child: Text("Add Item".tr)),
                )
              ],
            ),
            Expanded(
              child: PagedListView<int, StockDataModel>(
                  pagingController: _controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<StockDataModel>(
                      itemBuilder: (context, item, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
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
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Text(item.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        child: Text(
                                          '${'space'.tr} : ${item.capacity} ',
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13),
                                        )),
                                    Text(
                                      '${'Stock ID'.tr} : ${item.id}',
                                      style: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(() =>
                                              EnterInventoryScreen(data: item));
                                        },
                                        child: Text('Enter Stock'.tr,
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 110,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(item.photo)),
                            )
                          ],
                        ));
                  })),
            ),
          ],
        ));
  }
}
