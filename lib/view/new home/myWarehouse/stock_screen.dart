import 'package:dhliz_app/view/new%20home/myWarehouse/stock_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../controllers/home/stock_controller.dart';
import '../../../models/home/stock_model.dart';
import '../../../widgets/src/pagination_exception.dart';

class StockNewScreen extends StatefulWidget {
  final String id;

  const StockNewScreen({super.key, required this.id});

  @override
  State<StockNewScreen> createState() => _StockNewScreenState();
}

class _StockNewScreenState extends State<StockNewScreen> {
  final _controller = StockController.to;

  @override
  void initState() {
    _controller.id = widget.id;
    print(widget.id);
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
            'Stock Warehouse'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: PagedListView<int, StockDataModel>(
            pagingController: _controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<StockDataModel>(
                noItemsFoundIndicatorBuilder: (context) => PaginationException(
                  title: 'No items found'.tr,
                  message: 'The list is currently empty.'.tr,
                ),
                itemBuilder: (context, item, index) {
              print('555555555555555555555555555');
              print(item);
              print('555555555555555555555555555');
              return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: Text(
                                    '${'space'.tr} : ${item.capacity} ',
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 13),
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
                                    Get.to(
                                        () => StockDetailsScreen(data: item));
                                  },
                                  child: Text('view details'.tr,
                                      style:
                                          const TextStyle(color: Colors.black)),
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
