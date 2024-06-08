import 'package:dhliz_app/network/reset_api.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../models/home/stock_model.dart';

class StockByStatusController extends GetxController {
  static StockByStatusController get to =>
      Get.isRegistered<StockByStatusController>()
          ? Get.find<StockByStatusController>()
          : Get.put(StockByStatusController());

  bool isNotVisible = true;
  PagingController<int, StockDataModel> pagingController =
      PagingController(firstPageKey: 0);

  String? id;
  StockModel? stockModel;
  int currentPageSize = 0;

  Future<void> getStock({required int pageKey}) async {
    try {
      currentPageSize++;
      final result =
          await RestApi.getStockByStatus(skip: currentPageSize, take: 10);

      if (result != null && result.response.isNotEmpty) {
        final List<StockDataModel> flatList = result.response;
        final isLastPage = flatList.length < 10;
        if (isLastPage) {
          pagingController.appendLastPage(flatList);
        } else {
          pagingController.appendPage(
              flatList, 10); // Use a constant pageKey = 10
        }
      } else {
        pagingController.appendLastPage([]);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  refreshPagingController() {
    pagingController = PagingController(firstPageKey: 0);
    currentPageSize = 0; // Reset currentPageSize when refreshing the controller
    pagingController.addPageRequestListener((pageKey) {
      getStock(pageKey: pageKey);
    });
  }
}
