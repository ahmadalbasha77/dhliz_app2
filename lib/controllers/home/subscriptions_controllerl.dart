import 'package:dhliz_app/network/reset_api.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../models/home/subscriptions_model.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController get to =>
      Get.isRegistered<SubscriptionController>()
          ? Get.find<SubscriptionController>()
          : Get.put(SubscriptionController());

  bool isNotVisible = true;
  PagingController<int, SubscriptionDataModel> pagingController =
  PagingController(firstPageKey: 0);

  SubscriptionsModel? subscriptionsModel;
  int currentPageSize = 0;

  Future<void> getSubscription({required int pageKey}) async {
    try {
      print('7777777777777777777777777');
      currentPageSize++;
      final result =
      await RestApi.getSubscriptions(skip: currentPageSize, take: 10);

      update();
      if (result != null && result.response.isNotEmpty) {
        print('+++++++++++++++++++++++++++++++++');
        final List<SubscriptionDataModel> flatList = result.response;
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
      print(pagingController.error);
      print('555555555555555555555555555');
    }

  }

  refreshPagingController() {
    pagingController = PagingController(firstPageKey: 0);
    currentPageSize = 0;
    pagingController.addPageRequestListener((pageKey) {
      getSubscription(pageKey: pageKey);
    });
  }
}
