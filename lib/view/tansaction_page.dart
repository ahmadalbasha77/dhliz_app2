import 'package:dhliz_app/models/main/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/main/transaction_controller.dart';

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
    // _controller.refreshPagingController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        body: PagedListView<int, TransactionDataModel>(
            pagingController: _controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<TransactionDataModel>(
              itemBuilder: (context, item, index) => Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: screenSize.height * .012,
                                  horizontal: screenSize.width * .03),
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
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize.width * .05),
                          child: Text(
                              '${'Transaction ID'.tr} : ${item.transactionId}',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13)),
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
                                      color: Colors.black54, fontSize: 13)),
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
                                              : 'Rejected'.tr,
                                      style: TextStyle(
                                          color: item.status == 0
                                              ? Colors.amber
                                              : item.status == 1
                                                  ? Colors.green
                                                  : Colors.red,
                                          fontSize: 13)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    item.status == 0
                                        ? Icons.pending
                                        : item.status == 1
                                            ? Icons.check_circle_outline
                                            : Icons.cancel_outlined,
                                    color: item.status == 0
                                        ? Colors.amber
                                        : item.status == 1
                                            ? Colors.green
                                            : Colors.red,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                              icon: Icon(Icons.share, color: Colors.black),
                              label: Text(
                                'Share'.tr,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            child: item.actionType == 0
                                ? Icon(Icons.call_received, color: Colors.red)
                                : item.actionType == 1
                                    ? Icon(Icons.call_made_outlined,
                                        color: Colors.green)
                                    : Icon(Icons.moving, color: Colors.green)),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
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
            )));
  }
}
