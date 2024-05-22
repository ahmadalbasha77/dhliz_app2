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
      print('7777777777777777777777777');
      currentPageSize++;
      final result =
          await RestApi.getTransaction(skip: currentPageSize, take: 10);


      final count = await RestApi.getTransaction(skip: 0, take: 500);
      List<TransactionDataModel> transactions = count!.response;

      // Count transactions based on actionType
      countWithdraw = transactions.where((item) => item.actionType == 0).length;
      countEnter = transactions.where((item) => item.actionType == 1).length;
      countTransfer = transactions.where((item) => item.actionType == 2).length;

      print('************************************');
      print(countWithdraw);
      print(countEnter);
      print(countTransfer);
      print('************************************');
      update();
      if (result != null && result.response.isNotEmpty) {
        print('+++++++++++++++++++++++++++++++++');
        final List<TransactionDataModel> flatList = result.response;
        final isLastPage = flatList.length < 10;
        print(flatList.length);
        print(currentPageSize);
        print('999999999999999999999999');
        if (isLastPage) {
          print('aaaaaaaaaaaaaaaaaaa');
          pagingController.appendLastPage(flatList);
        } else {
          print('00000000000000000000000000');
          pagingController.appendPage(
              flatList, 10); // Use a constant pageKey = 10
        }
      } else {
        print('22222222222222222222222222222');
        pagingController.appendLastPage([]);
      }
    } catch (error) {
      print('555555555555555555555555555');
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
