import 'dart:async';
import 'package:get/get.dart';

import '../../models/main/notification_model.dart';
import '../../models/main/transaction_model.dart';
import '../../network/reset_api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionController extends GetxController {
  static TransactionController get to =>
      Get.isRegistered<TransactionController>()
          ? Get.find<TransactionController>()
          : Get.put(TransactionController());
  PagingController<int, TransactionDataModel> pagingController =
  PagingController(firstPageKey: 0);

  Future<void> getTransaction(
      {required int pageKey, String search = ''}) async {
    try {
      int pageSize = 10;
      final result = await RestApi.getTransactions(
          skip: pageKey, take: pageSize, search: search);
      final isLastPage = result.result.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(result.result.first.data);
      } else {
        final nextPageKey = pageKey + result.result.first.totalCount;
        pagingController.appendPage(result.result.first.data, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  refreshPagingController() {
    pagingController = PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener((pageKey) {
      getTransaction(pageKey: pageKey);
    });
  }
}
