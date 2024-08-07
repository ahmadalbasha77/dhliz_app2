import 'package:dhliz_app/config/app_color.dart';
import 'package:dhliz_app/widgets/src/custom_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Utils {
  static bool isNotEmpty(String? s) => s != null && s.isNotEmpty;

  static bool isEmpty(String? s) => s == null || s.isEmpty;

  static Future<bool?> showExitConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          // title: Text('Confirmation'),
          content: Text('Are you sure you want to exit the application?'.tr),
          actions: [
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Get.back(result: false);
              },
            ),
            TextButton(
              child: Text('Exit'.tr),
              onPressed: () {
                Get.back(result: true);
              },
            ),
          ],
        );
      },
    );
  }

  static showLoadingDialog([String? text]) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    if (!Get.isDialogOpen!) {
      Get.dialog(
        PopScope(
          canPop: true,
          child: CustomLoadingDialog(
            title: text ?? 'Loading ...',
          ),
        ),
        barrierDismissible: false,
        useSafeArea: false,
      );
    }
  }

  static showSnackBar(String title, String message) {
    hideLoadingDialog();
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 4),
      backgroundColor: AppColor.gray.withOpacity(0.5),
      margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
    );
  }

  static void hideLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static Future<bool> showAreYouSureDialog({required String title}) async {
    var result = await Get.defaultDialog(
      // buttonColor: Color.fromRGBO(80, 46, 144, 1.0),
      title: title,
      content: Text('Are you sure?'.tr),
      textCancel: 'Cancel'.tr,
      textConfirm: 'Confirm'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(result: true);
      },
      barrierDismissible: true,
    );
    return result ?? false;
  }
}
