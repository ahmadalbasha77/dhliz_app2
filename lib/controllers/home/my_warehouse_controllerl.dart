import 'dart:async';
import 'package:get/get.dart';
import '../../models/home/my_warehouse_model.dart';
import '../../network/reset_api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyWarehouseController extends GetxController {
  static MyWarehouseController get to => Get.isRegistered<MyWarehouseController>()
      ? Get.find<MyWarehouseController>()
      : Get.put(MyWarehouseController());
  PagingController<int, MyWarehouseDataModel> pagingController =
  PagingController(firstPageKey: 0);

  Future<void> getMyWarehouse({required int pageKey, String search = ''}) async {
    try {
      int pageSize = 10;
      final result = await RestApi.getMyWarehouses(
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
      getMyWarehouse(pageKey: pageKey);
    });
  }
}
