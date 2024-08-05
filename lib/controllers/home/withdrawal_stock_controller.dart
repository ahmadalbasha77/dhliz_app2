import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';

import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import '../../config/shared_prefs_client.dart';
import '../../network/api_url.dart';

class WithdrawalStockController extends GetxController {
  static WithdrawalStockController get to => Get.isRegistered<WithdrawalStockController>()
      ? Get.find<WithdrawalStockController>()
      : Get.put(WithdrawalStockController());

  TextEditingController space = TextEditingController();
  TextEditingController stockId = TextEditingController();
  TextEditingController date = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? selectedImage; // Use late for late initialization
  bool isSelectedOne = false;
  bool isSelectedOTwo = false;

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage = pickedImage;
      update();
    }
    update();
  }

  Future<void> _takePicture() async {
    final XFile? takenImage =
    await _imagePicker.pickImage(source: ImageSource.camera);
    if (takenImage != null) {
      selectedImage = takenImage;
      update();
    }
    update();
  }

  void showImageOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose an image".tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                trailing: Icon(Icons.photo),
                title: Text("From the gallery".tr),
                onTap: () {
                  _pickImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: Icon(Icons.camera),
                title: Text("Take photo".tr),
                onTap: () {
                  _takePicture();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> withdrawalStock(BuildContext context,{required String actionType}) async {
    var uri = Uri.parse('${ApiUrl.API_BASE_URL2}/api/Transaction/Create');
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer ${sharedPrefsClient.accessToken}'
      ..fields['Quantity'] = space.text
      ..fields['ActionType'] = actionType
      ..fields['Status'] = '0'
      ..fields['FromStockId'] = stockId.text
      ..fields['ToStockId'] = stockId.text
      ..fields['ProcessDate'] = date.text
    // ..fields['RejectReason'] = rejectReason.text
      ..files.add(await http.MultipartFile.fromPath(
          'DriverIdentityImage', selectedImage!.path,
          contentType: MediaType('image', 'png')));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {

        Get.back();
        Get.back();
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text:
            'A new withdrawal transaction request has been sent. Please wait for approval'.tr,
            showConfirmBtn: true,
            confirmBtnColor: Colors.white,
            confirmBtnTextStyle: const TextStyle(color: Colors.black),
            title: 'Completed Successfully!',
            textAlignment: TextAlign.center);
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'error transaction ',
            showConfirmBtn: true,
            confirmBtnColor: Colors.white,
            confirmBtnTextStyle: const TextStyle(color: Colors.black),
            title: 'Error!',
            textAlignment: TextAlign.center);
      }
    } catch (e) {
    }
  }
// Future<void> enterStock(BuildContext context) async {
//   bool result = await RestApi.createTransaction(jsonEncode({
//     "id": 0,
//     "quantity": space.text,
//     "actionType": 1,
//     "status": 0,
//     "fromStockId": stockId.text,
//     "toStockId": stockId.text,
//     "rejectReason": "string"
//   }));
//   if (result == true) {
//     Get.back();
//     Get.back();
//     QuickAlert.show(
//         context: context,
//         type: QuickAlertType.success,
//         text:
//             'A new entry transaction request has been sent. Please wait for approval',
//         showConfirmBtn: true,
//         confirmBtnColor: Colors.white,
//         confirmBtnTextStyle: const TextStyle(color: Colors.black),
//         title: 'Completed Successfully!',
//         textAlignment: TextAlign.center);
//   } else {
//     QuickAlert.show(
//         context: context,
//         type: QuickAlertType.error,
//         text: 'The subscription space is smaller than the required space',
//         showConfirmBtn: true,
//         confirmBtnColor: Colors.white,
//         confirmBtnTextStyle: const TextStyle(color: Colors.black),
//         title: 'Error!',
//         textAlignment: TextAlign.center);
//   }
// }
}
