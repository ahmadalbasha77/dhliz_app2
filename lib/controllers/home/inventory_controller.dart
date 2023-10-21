import 'dart:async';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../models/home/inventory_model.dart';
import '../../network/reset_api.dart';


class InventoryController extends GetxController {
  static InventoryController get to => Get.isRegistered<InventoryController>()
      ? Get.find<InventoryController>()
      : Get.put(InventoryController());
  PagingController<int, InventoryDataModel> pagingController =
  PagingController(firstPageKey: 0);

  Future<void> getInventory({required int pageKey, String search = ''}) async {
    try {
      int pageSize = 10;
      final result = await RestApi.getInventories(
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
      getInventory(pageKey: pageKey);
    });
  }
}
