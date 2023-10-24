import 'package:dhliz_app/view/home/self%20mangement%20of%20invntory/enter/my_warehouse/my_warehouse_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../config/utils.dart';
import '../../network/reset_api.dart';

class AddEditWarehouseController extends GetxController {
  static AddEditWarehouseController get to =>
      Get.isRegistered<AddEditWarehouseController>()
          ? Get.find<AddEditWarehouseController>()
          : Get.put(AddEditWarehouseController());
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

  addEditWarehouse() async {
    if (keyForm.currentState!.validate()) {
      Utils.showLoadingDialog();
      var result = await RestApi.addEditMyWarehouses(
        id: id.value,
        title: controllerTitle.text,
        description: 'controllerDescription.text',
        url: 'controllerUrl.text',
        date: DateTime.now(),
        isPro: false,
        image: image.value,
      );
      if (result.code == 200) {
        Utils.hideLoadingDialog();

        Get.off(const MyWareHouseScreen());
      } else {
        Utils.showSnackbar('Please try again'.tr, result.message);
      }
    }
  }
}
