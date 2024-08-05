import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../models/main/transaction_model.dart';
import '../../network/reset_api.dart';

class MatchingController extends GetxController {
  static MatchingController get to => Get.isRegistered<MatchingController>()
      ? Get.find<MatchingController>()
      : Get.put(MatchingController());

  bool isNotVisible = true;
  PagingController<int, TransactionDataModel> pagingController =
  PagingController(firstPageKey: 0);

  TransactionModel? transactionModel;
  int currentPageSize = 0;
  String customerNameFilter = '';

  void updateFilter(String newFilter) {
    customerNameFilter = newFilter;
    currentPageSize = 0;
    // refreshTransactions();
  }

  void refreshTransactions() {
    currentPageSize = 0;
    pagingController.refresh();
  }

  Future<void> getTransaction({
    required int pageKey,
  }) async {
    try {

      currentPageSize++;
      final result = await RestApi.getTransactionForMatching(
        skip: currentPageSize,
        take: 10,
        status: 2,
       // Use the class variable directly
      );

      if (result != null && result.response.isNotEmpty) {
        final List<TransactionDataModel> flatList = result.response;
        final isLastPage = flatList.length < 10;
        if (isLastPage) {
          pagingController.appendLastPage(flatList);
        } else {
          pagingController.appendPage(flatList, currentPageSize + 10);
        }
      } else {
        pagingController.appendLastPage([]);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void refreshPagingController() {
    pagingController = PagingController(firstPageKey: 0);
    currentPageSize = 0;
    pagingController.addPageRequestListener((pageKey) {
      getTransaction(
        pageKey: pageKey,
      );
    });
  }
}
