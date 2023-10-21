import 'dart:async';
import 'package:get/get.dart';

import '../../models/main/notification_model.dart';
import '../../network/reset_api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationController extends GetxController {
  static NotificationController get to =>
      Get.isRegistered<NotificationController>()
          ? Get.find<NotificationController>()
          : Get.put(NotificationController());
  PagingController<int, NotificationDataModel> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> getNotification(
      {required int pageKey, String search = ''}) async {
    try {
      int pageSize = 10;
      final result = await RestApi.getNotifications(
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
      getNotification(pageKey: pageKey);
    });
  }
}
