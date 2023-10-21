import 'dart:async';
import 'package:get/get.dart';

import '../../models/home/withdrawal_model.dart';
import '../../network/reset_api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WithdrawalController extends GetxController {
  static WithdrawalController get to => Get.isRegistered<WithdrawalController>()
      ? Get.find<WithdrawalController>()
      : Get.put(WithdrawalController());
  PagingController<int, WithdrawalDataModel> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> getWithdrawal({required int pageKey, String search = ''}) async {
    try {
      int pageSize = 10;
      final result = await RestApi.getWithdrawals(
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
      getWithdrawal(pageKey: pageKey);
    });
  }
}
