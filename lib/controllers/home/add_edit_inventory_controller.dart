import 'package:dhliz_app/view/home/self%20mangement%20of%20invntory/enter/inventory_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../config/utils.dart';
import '../../network/reset_api.dart';
import 'inventory_controller.dart';

class AddEditInventoryController extends GetxController {
  static AddEditInventoryController get to =>
      Get.isRegistered<AddEditInventoryController>()
          ? Get.find<AddEditInventoryController>()
          : Get.put(AddEditInventoryController());

  final _controller = InventoryController.to;
  final keyForm = GlobalKey<FormState>();
  final id = Rxn<String>();
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerUrl = TextEditingController();
  final controllerDate = TextEditingController();
  final isPro = false.obs;
  final image = Rxn<PlatformFile>();

  selectImage() async {
    var result =
        await Utils.pickImages(allowMultiple: false, type: FileType.image);
    if (result.isNotEmpty) {
      image.value = result.first;
      update();
    }
  }

  addEditInventory() async {
    if (keyForm.currentState!.validate()) {
      Utils.showLoadingDialog();
      var result = await RestApi.addEditInventory(
        id: id.value,
        title: controllerTitle.text,
        description: controllerDescription.text,
        url: controllerUrl.text,
        date: DateTime.now(),
        isPro: false,
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
  addEditInventory2() async {
    if (keyForm.currentState!.validate()) {
      Utils.showLoadingDialog();
      var result = await RestApi.addEditInventory(
        id: id.value,
        title: controllerTitle.text,
        description: controllerDescription.text,
        url: controllerUrl.text,
        date: DateTime.now(),
        isPro: false,
        image: image.value,
      );
      if (result.code == 200) {
        Utils.hideLoadingDialog();

        Get.off(InventoryScreen());
      } else {
        Utils.showSnackbar('Please try again'.tr, result.message);
      }
    }
  }
}
