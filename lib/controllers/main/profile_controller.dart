import 'package:get/get.dart';
import '../../config/shared_prefs_client.dart';
import '../../config/utils.dart';
import '../../models/main/profile_model.dart';
import '../../network/reset_api.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.isRegistered<ProfileController>() ? Get.find<ProfileController>() : Get.put(ProfileController());

  final profile = ProfileModel.fromJson({}).obs;

  Future<void> getProfile() async {
    Utils.showLoadingDialog();
    var result = await RestApi.getProfile();
    if (result.code == 200) {
      profile.value = result.result.first;
      sharedPrefsClient.fullName = profile.value.fullName;
      sharedPrefsClient.image = profile.value.image;
      update();
      Utils.hideLoadingDialog();
    } else {
      Utils.showSnackbar('Please try again'.tr, result.message);
    }
  }
}
