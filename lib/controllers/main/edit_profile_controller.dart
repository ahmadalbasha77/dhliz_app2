import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/utils.dart';

import 'package:platform_file/platform_file.dart' as thisFiles;

import '../../network/reset_api.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to =>
      Get.isRegistered<EditProfileController>()
          ? Get.find<EditProfileController>()
          : Get.put(EditProfileController());

  final keyForm = GlobalKey<FormState>();

  final controllerFullName = TextEditingController();
  final controllerHomeAddress = TextEditingController();
  final controllerWorkAddress = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerSyndicateNumber = TextEditingController();
  final image = Rxn<thisFiles.PlatformFile>();

  changeProfile() async {
    if (keyForm.currentState!.validate()) {
      Utils.showLoadingDialog();
      var result = await RestApi.changeProfile(
        fullName: controllerFullName.text,
        homeAddress: controllerHomeAddress.text,
        workAddress: controllerWorkAddress.text,
        email: controllerEmail.text,
        syndicateNumber: controllerSyndicateNumber.text,
        image: image.value,
      );
      if (result.code == 200) {
        Utils.hideLoadingDialog();
        Get.back();
      } else {
        Utils.showSnackbar('Please try again'.tr, result.message);
      }
    }
  }

  selectImage() async {
    var result =
        await Utils.pickImages(allowMultiple: false, type: FileType.image);
    if (result.isNotEmpty) {
      image.value = result.first as thisFiles.PlatformFile?;
      update();
    }
  }
}
