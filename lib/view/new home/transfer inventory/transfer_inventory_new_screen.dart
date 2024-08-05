import 'package:dhliz_app/controllers/home/stock_controller.dart';
import 'package:dhliz_app/models/home/stock_model.dart';
import 'package:dhliz_app/view/new%20home/transfer%20inventory/transfer_stock_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class TransferInventoryNewScreen extends StatefulWidget {
  final String id;

  const TransferInventoryNewScreen({super.key, required this.id});

  @override
  State<TransferInventoryNewScreen> createState() => _TransferInventoryNewScreenState();
}

class _TransferInventoryNewScreenState extends State<TransferInventoryNewScreen> {
  final _controller = StockController.to;

  @override
  void initState() {

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
            'Transfer Stock'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: PagedListView<int, StockDataModel>(
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
                                            TransferStockScreen(data: item));
                                      },
                                      child: Text('Transfer Stock'.tr,
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
                })));
  }
}
