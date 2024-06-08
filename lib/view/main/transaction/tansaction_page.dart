import 'package:dhliz_app/models/main/transaction_model.dart';
import 'package:dhliz_app/view/main/transaction/ststus_storck_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controllers/main/transaction_controller.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _controller = TransactionController.to;

  @override
  void initState() {
    super.initState();
    _controller.pagingController.addPageRequestListener((pageKey) {
      _controller.getTransaction(pageKey: pageKey);
    });

    _controller.refreshPagingController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          title: Text('Transactions'.tr, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            GetBuilder<TransactionController>(
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // margin: EdgeInsets.only(
                    //   left: screenSize.width * .05,
                    //   right: screenSize.width * .05,
                    // ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: screenSize.height * .005),
                          child: Text('Enter inventory'.tr,
                              style: TextStyle(color: Colors.black54)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: screenSize.height * .005),
                          child: Text(_controller.countEnter.toString(),
                              style: TextStyle(fontSize: 27)),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * .005),
                            child: Container(
                              padding: EdgeInsets.all(screenSize.height * .005),
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * .03),
                                  child: Text('Enters'.tr,
                                      style:
                                          TextStyle(color: Colors.green[300])),
                                ),
                                Icon(
                                  Icons.call_made_outlined,
                                  color: Colors.green,
                                  size: screenSize.height * .015,
                                )
                              ]),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width * .005,
                        vertical: screenSize.height * .018),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: screenSize.height * .005),
                          child: Text('Withdrawal'.tr,
                              style: TextStyle(color: Colors.black54)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: screenSize.height * .005),
                          child: Text(_controller.countWithdraw.toString(),
                              style: TextStyle(fontSize: 27)),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * .005),
                            child: Container(
                              padding: EdgeInsets.all(screenSize.height * .005),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * .02),
                                  child: Text('Withdrawals'.tr,
                                      style: TextStyle(color: Colors.red[400])),
                                ),
                                Icon(
                                  Icons.call_received,
                                  color: Colors.red,
                                  size: screenSize.height * .015,
                                )
                              ]),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: screenSize.height * .005),
                          child: Text('Transfer'.tr,
                              style: TextStyle(color: Colors.black54)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: screenSize.height * .005),
                          child: Text(_controller.countTransfer.toString(),
                              style: TextStyle(fontSize: 27)),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: screenSize.height * .005),
                            child: Container(
                              padding: EdgeInsets.all(screenSize.height * .005),
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * .03),
                                  child: Text('Transfer'.tr,
                                      style: TextStyle(color: Colors.green)),
                                ),
                                Icon(
                                  Icons.moving,
                                  color: Colors.green,
                                  size: screenSize.height * .015,
                                )
                              ]),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PagedListView<int, TransactionDataModel>(
                  pagingController: _controller.pagingController,
                  builderDelegate:
                      PagedChildBuilderDelegate<TransactionDataModel>(
                          itemBuilder: (context, item, index) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin:
                              EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical:
                                                  screenSize.height * .012,
                                              horizontal:
                                                  screenSize.width * .03),
                                          child: Text(item.stockName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                        ),

                                        // Container(
                                        //   margin: EdgeInsets.symmetric(
                                        //       vertical:
                                        //           screenSize.height * .012,
                                        //       horizontal:
                                        //           screenSize.width * .18),
                                        //   child: Text('${'Date'.tr} : 12/10 ',
                                        //       style: TextStyle(
                                        //           color: Colors.black38,
                                        //           fontSize: 12,
                                        //           fontWeight: FontWeight.w500)),
                                        // ),
                                        // Container(
                                        //   margin: EdgeInsets.symmetric(
                                        //       horizontal:
                                        //           screenSize.width * .028,
                                        //       vertical:
                                        //           screenSize.height * .012),
                                        //   child: Text('time :  11:30 ',
                                        //       style: TextStyle(
                                        //           color: Colors.black26,
                                        //           fontSize: 12,
                                        //           fontWeight: FontWeight.w500)),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * .05),
                                    child: Text(
                                        '${'Transaction ID'.tr} : ${item.transactionId}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13)),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: screenSize.width * .05,
                                            vertical: screenSize.width * .03),
                                        child: Text(
                                            '${'Quantity'.tr}  : ${item.quantity}',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: screenSize.width * .05,
                                            vertical: screenSize.width * .03),
                                        child: Row(
                                          children: [
                                            Text(
                                                item.status == 0
                                                    ? 'Under Review'.tr
                                                    : item.status == 1
                                                        ? 'Accepted'.tr
                                                        : item.status == 2
                                                            ? 'Rejected'.tr
                                                            : 'Preliminary Approval',
                                                style: TextStyle(
                                                    color: item.status == 0
                                                        ? Colors.amber
                                                        : item.status == 1
                                                            ? Colors.green
                                                            : item.status == 2
                                                                ? Colors.red
                                                                : Colors.green,
                                                    fontSize: 12)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              item.status == 0
                                                  ? Icons.pending
                                                  : item.status == 1
                                                      ? Icons
                                                          .check_circle_outline
                                                      : item.status == 2
                                                          ? Icons
                                                              .cancel_outlined
                                                          : Icons.pending,
                                              color: item.status == 0
                                                  ? Colors.amber
                                                  : item.status == 1
                                                      ? Colors.green
                                                      : item.status == 2
                                                          ? Colors.red
                                                          : Colors.green,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: screenSize.width * .05),
                                        child: TextButton.icon(
                                            onPressed: () {
                                              Share.share(
                                                'Transactions Details  \n\nName Item : ${item.stockName}   \n\n Transactions Id :${item.transactionId}  \n\n '
                                                'quantity : ${item.quantity} \n\n status :  ${item.status == 0 ? 'Under Review'.tr : item.status == 1 ? 'Accepted'.tr : 'Rejected'.tr}'
                                                '  ',
                                              );
                                            },
                                            icon: Icon(
                                              Icons.share,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            label: Text(
                                              'Share'.tr,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            )),
                                      ),
                                      item.status == 1 || item.status == 3
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenSize.width * .05),
                                              child: TextButton.icon(
                                                  onPressed: () {
                                                    Get.to(() =>
                                                        StatusStockScreen(
                                                            stockId: item
                                                                .fromStockId,
                                                            transactionId: item
                                                                .transactionId));
                                                  },
                                                  icon: Icon(
                                                      Icons
                                                          .view_agenda_outlined,
                                                      color: Colors.black,
                                                      size: 20),
                                                  label: Text(
                                                    'Status Stock'.tr,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                  )),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      child: item.actionType == 0
                                          ? Icon(Icons.call_received,
                                              color: Colors.red)
                                          : item.actionType == 1
                                              ? Icon(Icons.call_made_outlined,
                                                  color: Colors.green)
                                              : Icon(Icons.moving,
                                                  color: Colors.green)),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        item.actionType == 0
                                            ? 'Withdrawal'.tr
                                            : item.actionType == 1
                                                ? 'Enter'.tr
                                                : 'Transfer'.tr,
                                        style: TextStyle(color: Colors.black54),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  })),
            ),
          ],
        ));
  }
}
