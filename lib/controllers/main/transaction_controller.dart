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

  Future<void> getTransaction({required int pageKey}) async {
    try {
      int pageSize = 10; // Assuming 10 items per page
      final result = await RestApi.getTransaction(skip: pageKey, take: pageSize);
      if (result != null && result.response.isNotEmpty) {
        final List<TransactionDataModel> flatList = result.response.expand((x) => x).toList();
        print(flatList.length);
        final isLastPage = flatList.length < pageSize;
        print(isLastPage);
        if (isLastPage) {
          pagingController.appendLastPage(flatList);
        } else {
          final nextPageKey = pageSize + flatList.length; // Adjust this line as needed
          print(nextPageKey);
          pagingController.appendPage(flatList, nextPageKey);
        }
      } else {
        // If no data is returned, consider appending an empty list or handling as last page
        pagingController.appendLastPage([]);
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
