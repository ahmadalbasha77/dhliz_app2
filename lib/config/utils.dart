import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:dhliz_app/config/app_color.dart';
import 'package:dhliz_app/widgets/src/custom_loading_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';

class Utils {
  static bool isNotEmpty(String? s) => s != null && s.isNotEmpty;

  static bool isEmpty(String? s) => s == null || s.isEmpty;

  static showLoadingDialog([String? text]) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    if (!Get.isDialogOpen!) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async => true,
          child: CustomLoadingDialog(
            title: text ?? 'Loading ...',
          ),
        ),
        barrierDismissible: false,
        useSafeArea: false,
      );
    }
  }

  static showSnackbar(String title, String message) {
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

  static Future<List<PlatformFile>> pickImages(
      {bool allowMultiple = true,
      FileType type = FileType.image,
      List<String>? allowedExtensions}) async {
    try {
      var pickFiles = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        type: type,
        allowedExtensions: allowedExtensions,
        withData: true,
        onFileLoading: (FilePickerStatus status) => log(status.toString()),
      );
      return pickFiles?.files ?? [];
    } on PlatformException catch (e) {
      log('Unsupported operation $e');
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
