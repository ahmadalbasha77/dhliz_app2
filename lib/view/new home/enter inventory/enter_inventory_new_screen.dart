import 'package:dhliz_app/controllers/home/stock_controller.dart';
import 'package:dhliz_app/models/home/stock_model.dart';
import 'package:dhliz_app/view/new%20home/enter%20inventory/enter_inventory_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'add stock/add_strok_screen.dart';

class EnterInventoryNewScreen extends StatefulWidget {
  final String id;

  const EnterInventoryNewScreen({super.key, required this.id});

  @override
  State<EnterInventoryNewScreen> createState() =>
      _EnterInventoryNewScreenState();
}

class _EnterInventoryNewScreenState extends State<EnterInventoryNewScreen> {
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
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 35.w, vertical: 10.h)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(80, 46, 144, 1.0))),
                      onPressed: () {
                        Get.off(() => AddStockNewScreen(
                              id: _controller.id.toString(),
                            ));
                      },
                      child: Text("Add Item".tr))
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: PagedListView<int, StockDataModel>(
                    pagingController: _controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<StockDataModel>(
                        itemBuilder: (context, item, index) {
                      return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10,bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${'Stock ID'.tr} : ${item.id}',
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${'space'.tr} : ${item.capacity}',
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    TextButton(
                                      style: const ButtonStyle(
                                          padding: MaterialStatePropertyAll(
                                              EdgeInsets.all(0))),
                                      onPressed: () {
                                        Get.to(() =>
                                            EnterInventoryScreen(data: item));
                                      },
                                      child: Text('Enter Stock'.tr,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(item.photo))
                            ],
                          ));
                    })),
              ),
            ],
          ),
        ));
  }
}
