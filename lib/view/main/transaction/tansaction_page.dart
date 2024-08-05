import 'package:dhliz_app/models/main/transaction_model.dart';
import 'package:dhliz_app/view/main/transaction/ststus_storck_screen.dart';
import 'package:dhliz_app/widgets/transactions/count_transactions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controllers/main/transaction_controller.dart';
import '../../../widgets/src/pagination_exception.dart';

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
          elevation: 0,
          title: Text(
            'Transactions'.tr,
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            GetBuilder<TransactionController>(
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CountTransactionWidget(
                      title: 'Enter inventory',
                      type: 'Enters',
                      color: Colors.greenAccent.withOpacity(0.2),
                      icon: Icons.call_made_outlined,
                      iconColor: Colors.green,
                      count: _controller.countEnter),
                  CountTransactionWidget(
                      title: 'Withdrawal',
                      type: 'Withdrawals',
                      color: Colors.redAccent.withOpacity(0.2),
                      icon: Icons.call_received,
                      iconColor: Colors.red,
                      count: _controller.countWithdraw),
                  CountTransactionWidget(
                      title: 'Transfer',
                      type: 'Transfer',
                      color: Colors.greenAccent.withOpacity(0.2),
                      icon: Icons.moving,
                      iconColor: Colors.green,
                      count: _controller.countTransfer),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: PagedListView<int, TransactionDataModel>(
                  pagingController: _controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<
                          TransactionDataModel>(
                      noItemsFoundIndicatorBuilder: (context) =>
                          PaginationException(
                            title: 'No items found'.tr,
                            message: 'The list is currently empty'.tr,
                          ),
                      itemBuilder: (context, item, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 7.h),
                          margin: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.stockName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                        '${'Transaction ID'.tr} : ${item.transactionId}',
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13)),
                                    Row(
                                      children: [
                                        Text(
                                            '${'Quantity'.tr}  : ${item.quantity}',
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13)),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  screenSize.width * .05,
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
                                                              : item.matchingStatus ==
                                                                      2
                                                                  ? 'Waiting for your review'
                                                                      .tr
                                                                  : 'Preliminary Approval'
                                                                      .tr,
                                                  style: TextStyle(
                                                      color: item.status == 0
                                                          ? Colors.amber
                                                          : item.status == 1
                                                              ? Colors.green
                                                              : item.status == 2
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green,
                                                      fontSize: 10)),
                                              SizedBox(
                                                width: 3.w,
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
                                        TextButton.icon(
                                            onPressed: () {
                                              Share.share(
                                                'Transactions Details  \n\nName Item : ${item.stockName}   \n\n Transactions Id :${item.transactionId}  \n\n '
                                                'quantity : ${item.quantity} \n\n status :  ${item.status == 0 ? 'Under Review'.tr : item.status == 1 ? 'Accepted'.tr : 'Rejected'.tr}'
                                                '  ',
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.share,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            label: Text(
                                              'Share'.tr,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            )),
                                        if (item.status == 1 ||
                                            item.status == 3)
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    screenSize.width * .05),
                                            child: TextButton.icon(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      StatusStockScreen(
                                                          data: item,
                                                          stockId:
                                                              item.fromStockId,
                                                          transactionId: item
                                                              .transactionId));
                                                },
                                                icon: const Icon(
                                                    Icons.view_agenda_outlined,
                                                    color: Colors.black,
                                                    size: 20),
                                                label: Text(
                                                  'Status Stock'.tr,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                )),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                      child: item.actionType == 0
                                          ? const Icon(Icons.call_received,
                                              color: Colors.red)
                                          : item.actionType == 1
                                              ? const Icon(
                                                  Icons.call_made_outlined,
                                                  color: Colors.green)
                                              : const Icon(Icons.moving,
                                                  color: Colors.green)),
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        item.actionType == 0
                                            ? 'withdrawal'.tr
                                            : item.actionType == 1
                                                ? 'enter'.tr
                                                : 'transfer'.tr,
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ))
                                ],
                              )
                            ],
                          ),
                        );
                      })),
            ),
          ],
        ));
  }
}
