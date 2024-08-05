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
  int currentPageSize = 0;
  int countWithdraw= 0 ;
  int countEnter = 0;
  int countTransfer = 0;

  Future<void> getTransaction({required int pageKey}) async {
    try {
      currentPageSize++;
      final result =
          await RestApi.getTransaction(skip: currentPageSize, take: 10);


      final count = await RestApi.getTransaction(skip: 0, take: 500);
      List<TransactionDataModel> transactions = count!.response;

      // Count transactions based on actionType
      countWithdraw = transactions.where((item) => item.actionType == 0).length;
      countEnter = transactions.where((item) => item.actionType == 1).length;
      countTransfer = transactions.where((item) => item.actionType == 2).length;

      update();
      if (result != null && result.response.isNotEmpty) {
        final List<TransactionDataModel> flatList = result.response;
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
    currentPageSize = 0;
    pagingController.addPageRequestListener((pageKey) {
      getTransaction(pageKey: pageKey);
    });
  }
}
