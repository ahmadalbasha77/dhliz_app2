import 'dart:async';
import 'package:get/get.dart';
import '../../models/home/transfer_warehouse_model.dart';
import '../../network/reset_api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransferWarehousesController extends GetxController {
  static TransferWarehousesController get to => Get.isRegistered<TransferWarehousesController>()
      ? Get.find<TransferWarehousesController>()
      : Get.put(TransferWarehousesController());
  PagingController<int, TransferWarehouseDataModel> pagingController =
  PagingController(firstPageKey: 0);

  Future<void> getTransferWarehouse({required int pageKey, String search = ''}) async {
    try {
      int pageSize = 10;
      final result = await RestApi.getTransferWarehouses(
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
      getTransferWarehouse(pageKey: pageKey);
    });
  }
}
