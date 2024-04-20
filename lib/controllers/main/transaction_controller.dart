import 'package:dhliz_app/models/main/transaction_model.dart';
import 'package:dhliz_app/network/reset_api.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionController extends GetxController {
  static TransactionController get to =>
      Get.isRegistered<TransactionController>()
          ? Get.find<TransactionController>()
          : Get.put(TransactionController());

  bool isNotVisible = true;
  PagingController<int, TransactionDataModel> pagingController =
      PagingController(firstPageKey: 0);

  TransactionModel? transactionModel;
  int currentPageSize = 0; // Initialize currentPageSize

  Future<void> getTransaction({required int pageKey}) async {
    try {
      currentPageSize++; // Increase pageSize with each call
      final result = await RestApi.getTransaction(
          skip: currentPageSize, take: 10); // Use a constant pageKey = 10

      if (result != null && result.response.isNotEmpty) {
        final List<TransactionDataModel> flatList =
            result.response.expand((x) => x).toList();
        final isLastPage = flatList.length < currentPageSize;
        if (isLastPage) {
          pagingController.appendLastPage(flatList);
          flatList.forEach((transaction) {
            print('Action Type: ${transaction.actionType}');
          });
        } else {
          // Keep the nextPageKey as 10 always
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
      getTransaction(pageKey: pageKey);
    });
  }
}
