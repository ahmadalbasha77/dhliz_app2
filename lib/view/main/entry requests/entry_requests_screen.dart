import 'package:dhliz_app/controllers/home/stock_controller.dart';
import 'package:dhliz_app/models/home/stock_model.dart';
import 'package:dhliz_app/view/new%20home/enter%20inventory/enter_inventory_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controllers/home/stock_by_status_controller.dart';
import '../../../models/main/transaction_model.dart';
import '../transaction/ststus_storck_screen.dart';

class EntryRequestsScreen extends StatefulWidget {
  const EntryRequestsScreen({
    super.key,
  });

  @override
  State<EntryRequestsScreen> createState() => _EntryRequestsScreenState();
}

class _EntryRequestsScreenState extends State<EntryRequestsScreen> {
  final _controller = MatchingController.to;

  @override
  void initState() {
    super.initState();
    _controller.pagingController.addPageRequestListener((pageKey) {
      _controller.getTransaction(pageKey: pageKey);
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
            'Entry Requests'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
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
                                                          data: item,
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
